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
    let location = try container.decode(Location.self, forKey: .region)
    region = CLLocation(latitude: location.latitude, longitude: location.longitude)
  }
}

private struct Location: Decodable {
  let longitude: Double
  let latitude: Double
  
  enum CodingKeys: CodingKey {
    case center
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let values = try container.decodeIfPresent(Location.self, forKey: .center)
    
    latitude = values?.latitude ?? 0
    longitude = values?.longitude ?? 0
  }
}
