//
//  YelpAPIRequest.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-01.
//

import Foundation
import Networking
import Combine
import CoreLocation

class YelpRequest: HTTPRequest {
  typealias HTTPResponse = [Restaurant]

  let path: String
  let method: HTTPMethod
  let headers: [String : String]
  let parameters: [String : String]
  let resource: Resource<[Restaurant]>
  
  private let staticPath: StaticString
  private lazy var requestBuilder: some URLRequestBuilding
    = URLRequestBuilder(URL(staticPath))
  
  init(
    path: StaticString,
    headers: [String : String],
    parameters: [String : String],
    resource: Resource<[Restaurant]> = Resource<[Restaurant]>()
  ) {
    self.path = path.toString()
    self.headers = headers
    self.parameters = parameters
    self.staticPath = path
    self.resource = resource
    self.method = .GET
  }
  
  func build() -> URLRequest {
    requestBuilder.withRequestType(method: method)
    requestBuilder.addQueryItems(for: parameters)
    requestBuilder.withHeaderOptions(headers: headers)
    return requestBuilder.retrieveRequest()
  }
}

extension YelpRequest {
  static func preview() -> YelpRequest {
    YelpRequest(
      path: "",
      headers: [:],
      parameters: [:],
      resource: Resource<[Restaurant]>()
    )
  }
}
