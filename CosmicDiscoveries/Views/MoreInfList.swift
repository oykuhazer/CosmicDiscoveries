//
//  MoreInfList.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 16.08.2023.
//

import UIKit
import Alamofire
import Combine

class MoreInfList: UIViewController  {
    
     var tableView: UITableView!
     var viewModel = MoreInfListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
        viewModel.fetchTitles()
        
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TitleCell")
        tableView.backgroundColor = UIColor(red: 5/255, green: 10/255, blue: 25/255, alpha: 1.0)
        view.addSubview(tableView)
    }
    
    //Bind the ViewModel to update UI
       private func bindViewModel() {
           //Update table view sections
           viewModel.$sections
               .receive(on: DispatchQueue.main)
               .sink { [weak self] sections in
                   self?.tableView.reloadData()
               }
               .store(in: &cancellables)
           
           //Update table view when section expansion changes
           viewModel.$sectionIsExpanded
               .receive(on: DispatchQueue.main)
               .sink { [weak self] _ in
                   self?.tableView.reloadData()
               }
               .store(in: &cancellables)
       }
   }
