//
//  RestaurantListViewRepresentable.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-23.
//

import Foundation
import SwiftUI

struct RestaurantListViewRepresentable: UIViewRepresentable {
  let viewController: RestaurantTableViewController

  func makeUIView(context: Context) -> some UIView {
    viewController.view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {}
}
