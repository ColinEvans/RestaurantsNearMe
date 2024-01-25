//
//  RestaurantListRow.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-24.
//

import SwiftUI

struct RestaurantListRow: View {
  let restaurant: Restaurant
  @Environment(\.displayScale) var scale

  var body: some View {
    GeometryReader { proxy in
      HStack(spacing: proxy.size.width * UIConstants.widthRatio){
        AsyncImage(
          url: URL(string: restaurant.imagePath)!,
          scale: scale,
          transaction: .init(animation: .bouncy)
        ) { phase in
          switch phase {
          case .success(let image):
            image.iconImage()
          default:
            Image("placeholder_image").iconImage()
          }
        }
        .frame(width: 75, height: 75)

        VStack(alignment: .leading){
          Text(restaurant.name)
            .font(.system(.title2))
          Text("Rating: \(String(restaurant.rating))")
            .font(.system(.caption))
            .foregroundStyle(.secondary)
        }
      }.padding(.leading)
    }
  }
  
  private struct UIConstants {
    static let widthRatio: CGFloat = 0.05
  }
}

#Preview {
  RestaurantListRow(restaurant: .preview())
}