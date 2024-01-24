//
//  RestaurantTableViewCell.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-23.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
  
  let header = UITextField(frame: .zero)
  let rating = UITextField(frame: .zero)
  var image: UIImage?
  
  private lazy var textStackView = UIStackView(
    arrangedSubviews: [header, rating]
  )
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func commonInit() {
    setupStackView()
    
    self.addSubview(textStackView)
    
    
    NSLayoutConstraint.activate(
      [
        textStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        textStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        textStackView.heightAnchor.constraint(equalTo: heightAnchor),
        textStackView.widthAnchor.constraint(equalTo: widthAnchor)
      ]
    )
  }
  
  private func setupStackView() {
    textStackView.axis = .vertical
    textStackView.alignment = .center
    textStackView.translatesAutoresizingMaskIntoConstraints = false
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  
  private struct UIConstants {
    static let spacing: CGFloat = 10
  }

}
