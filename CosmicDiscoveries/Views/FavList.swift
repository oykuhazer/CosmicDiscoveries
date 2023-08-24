//
//  FavList.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 16.08.2023.
//

import UIKit
import Alamofire
import Combine

class FavList: UIViewController  {
    
    var tableView: UITableView!
         var viewModel: FavListViewModel!

         override func viewDidLoad() {
             super.viewDidLoad()
             setupUI()
             viewModel = FavListViewModel()
             NotificationCenter.default.addObserver(self, selector: #selector(handleSavedDatesUpdate), name: NSNotification.Name("SavedDatesUpdated"), object: nil)
         }

           func setupUI() {
               view.backgroundColor = UIColor(red: 174/255, green: 193/255, blue: 217/255, alpha: 1.0)
               setupTableView()
           }

           func setupTableView() {
               tableView = UITableView()
               tableView.dataSource = self
               tableView.delegate = self
               tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
               tableView.translatesAutoresizingMaskIntoConstraints = false
               tableView.backgroundColor = UIColor(red: 174/255, green: 193/255, blue: 217/255, alpha: 1.0)
               view.addSubview(tableView)

               NSLayoutConstraint.activate([
                   tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                   tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
           }

    //Handle the notification when saved dates are updated
    @objc func handleSavedDatesUpdate() {
        tableView.reloadData()
    }
}
  
          
      
