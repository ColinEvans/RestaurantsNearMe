//
//  YelpRequestProvider.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-10.
//

import Foundation
import CoreLocation
import Combine
import Networking

class YelpRequestProvider {
  let activeRequest = CurrentValueSubject<YelpRequest?, Never>(nil)
  private var cancellables = Set<AnyCancellable>()
  
  init(
    locationProvider: some LocationProviding,
    cloudKitServiceProvider: some CloudKitServiceProviding,
    baseURLPath: StaticString
  ) {
    locationProvider.currentLocation
      .map { self.translateToQueryDict(from: $0) }
      .combineLatest(cloudKitServiceProvider.fetchedAPIKey.map { self.translateToHeader(from: $0.value)})
      .receive(on: RunLoop.main)
      .sink { locationParameters, authHeader in
        let request = YelpRequest(
          path: baseURLPath,
          headers: authHeader,
          parameters: locationParameters,
          resource: Resource<[Restaurant]>(
            parse: {
              do {
                let decodedData = try JSONDecoder().decode(YelpResult.self, from: $0)
                return decodedData.businesses
              } catch {
                throw YelpRequestError.unableToParseRestaurants
              }
            }
          )
        )
        self.activeRequest.send(request)
      }.store(in: &cancellables)
  }
  
  private func translateToQueryDict(from location: CLLocation) -> [String : String] {
    [
      "latitude" : String(location.coordinate.latitude),
      "longitude" : String(location.coordinate.longitude)
    ]
  }
  
  private func translateToHeader(from str: String?) -> [String : String] {
    guard let privateKey = str else { return [ : ] }
    return [HeaderType.auth.rawValue : "Bearer " + privateKey]
  }
}
