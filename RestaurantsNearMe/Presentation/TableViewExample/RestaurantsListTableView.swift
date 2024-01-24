//
//  RestaurantsListTableView.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-23.
//

import UIKit

class RestaurantsListTableView: UITableView {

  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.register(RestaurantTableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
