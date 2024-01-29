//
//  YelpResult.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-22.
//

import Foundation
import CoreLocation

struct YelpResult: Decodable {
  let businesses: [Restaurant]
  let total: Int
  let region: CLLocation
  
  enum CodingKeys: String, CodingKey {
    case businesses, total, region
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    businesses = try container.decode([Restaurant].self, forKey: .businesses)
    total = (try? container.decodeIfPresent(Int.self, forKey: .total)) ?? 0
    let value = try container.decode(Region.self, forKey: .region)
    region = CLLocation(
      latitude: value.center.latitude,
      longitude: value.center.longitude
    )
  }
  
  // MARK: - Private Struct for Decoding
  private struct Region: Decodable {
    let center: Location
    
    struct Location: Decodable {
      let longitude: Double
      let latitude: Double
    }
  }
}
