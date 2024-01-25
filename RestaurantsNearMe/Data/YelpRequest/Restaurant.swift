//
//  Restaurant.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-10.
//

import Foundation

struct Restaurant: Identifiable {
  let id: String
  let name: String
  let rating: Double
  let imagePath: String
  
  enum CodingKeys: CodingKey {
    case id
    case name
    case rating
    case image_url
  }
  
  init(id: String, name: String, rating: Double, imagePath: String) {
    self.id = id
    self.name = name
    self.rating = rating
    self.imagePath = imagePath
  }
  
}

// MARK: - Extensions<Decodable>
extension Restaurant: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.rating = try container.decode(Double.self, forKey: .rating)
    self.imagePath = try container.decode(String.self, forKey: .image_url)
  }
}

// MARK: - Extensions UI Preview
extension Restaurant {
  static func preview() -> Restaurant {
    Restaurant(
      id: "1qx37",
      name: "Example",
      rating: 5.0,
      imagePath: "https://s3-media3.fl.yelpcdn.com/bphoto/w3i_dVIjGTyIeiYXUzumkA/o.jpg"
    )
  }
}
