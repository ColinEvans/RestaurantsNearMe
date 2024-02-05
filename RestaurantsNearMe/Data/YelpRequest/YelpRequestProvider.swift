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
    offsetProvider: some OffsetProviding,
    baseURLPath: StaticString
  ) {
    locationProvider.currentLocation
      .combineLatest(
        cloudKitServiceProvider.fetchedAPIKey.map { self.translateToHeader(from: $0.value)},
        offsetProvider.currentPageOffset
      )
      .receive(on: RunLoop.main)
      .sink { [unowned self] location, authHeader, offset in
        let queryParams = self.translateToQueryDict(from: location, offSet: offset)
        let request = YelpRequest(
          path: baseURLPath,
          headers: authHeader,
          parameters: queryParams,
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
  
  private func translateToQueryDict(
    from location: CLLocation,
    offSet: Int
  ) -> [String : String] {
    [
      "latitude" : String(location.coordinate.latitude),
      "longitude" : String(location.coordinate.longitude),
      "offset" : String(offSet)
    ]
  }
  
  private func translateToHeader(from str: String?) -> [String : String] {
    guard let privateKey = str else { return [ : ] }
    return [HeaderType.auth.rawValue : "Bearer " + privateKey]
  }
}
