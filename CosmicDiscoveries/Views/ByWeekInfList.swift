//
//  ByWeekInfList.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 16.08.2023.
//

import UIKit
import Alamofire
import Combine

class ByWeekInfList: UIViewController {
    
    var collectionView: UICollectionView!
     var viewModel = ByWeekInfListViewModel()
     private var cancellables: Set<AnyCancellable> = []
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         title = "Weekly News"
         view.backgroundColor = .white
         
         setupCollectionView()
         bindViewModel()
         viewModel.fetchArticles()
     }
     
     func setupCollectionView() {
         let layout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: view.frame.width, height: 100)
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 1
         
         collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.dataSource = self
         collectionView.delegate = self
         collectionView.backgroundColor = .white
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ArticleCell")
         
         view.addSubview(collectionView)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }
     
    //Bind ViewModel to update the collection view
      func bindViewModel() {
          viewModel.articlesPublisher
              .sink { [weak self] articles in
                  self?.collectionView.reloadData()
              }
              .store(in: &cancellables)
      }
  }
