//
//  RestaurantTableViewController.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2024-01-23.
//

import UIKit
import RxSwift

class RestaurantTableViewController: UIViewController {
  let viewModel:  RestaurantListViewModel
  let tableView: RestaurantsListTableView
  private let bag = DisposeBag()
  
  // MARK: - Lifecycle Functions
  init(viewModel: RestaurantListViewModel) {
    self.viewModel = viewModel
    self.tableView = RestaurantsListTableView(frame: .zero, style: .plain)
    super.init(nibName: nil, bundle: Bundle.main)
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
    setupTalbeView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Task {
      await viewModel.retrieveRestaurants()
      await MainActor.run {
        tableView.reloadData()
      }
    }
  }
  
  // Setup the bindings
  private func setupBindings() {
    viewModel.restaurantsList
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(
        onNext: { [unowned self] list in
        
        }
      ).disposed(by: bag)
  }
  
  private func setupTalbeView() {
    print(self.view.frame)
    view.addSubview(tableView)
    NSLayoutConstraint.activate(
      [
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ]
    )
  }
}

// MARK: - Table view data source
extension RestaurantTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.restaurants.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RestaurantTableViewCell else {
      return UITableViewCell()
    }
    let data = viewModel.restaurants[indexPath.row]
    cell.header.text = data.name
    cell.rating.text = viewModel.formatRating(for: data.rating)
    return cell
  }
}


// MARK: - Table view delegate
extension RestaurantTableViewController: UITableViewDelegate {
  
}
