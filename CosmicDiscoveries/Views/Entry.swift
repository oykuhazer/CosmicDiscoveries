//
//  Entry.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 16.08.2023.
//

import UIKit
import Combine

class Entry: UIViewController {
    
    var cellIdentifier = "SpaceCell"
    var viewModel = SpaceViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 50, height: 80)
        layout.minimumInteritemSpacing = 40
        layout.minimumLineSpacing = 40

        let collectionView = UICollectionView(frame: CGRect(x: (view.bounds.width - (view.bounds.width - 20)) / 2,
                                                            y: view.bounds.height / 2.5,
                                                            width: view.bounds.width - 20,
                                                            height: view.bounds.height),
                                              collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
           viewModel.onDataUpdate = { [weak self] in
               self?.collectionView.reloadData()
           }
           viewModel.fetchSpaceItems()
       }

           private func setupUI() {
               view.backgroundColor = UIColor(red: 13/255, green: 28/255, blue: 51/255, alpha: 1.0)

               let titleLabel = createLabel(frame: CGRect(x: 0, y: view.bounds.height / 7, width: view.bounds.width, height: 100),
                                            text: "Welcome to the Fascinating World of Space!",
                                            fontSize: 24)
               let subTitleLabel = createLabel(frame: CGRect(x: 0, y: view.bounds.height / 4.5, width: view.bounds.width, height: 100),
                                               text: "Discover the Secrets of the Universe in Space Exploration App!",
                                               fontSize: 18)

               [titleLabel, subTitleLabel, collectionView].forEach { view.addSubview($0) }
           }

           private func createLabel(frame: CGRect, text: String, fontSize: CGFloat) -> UILabel {
               let label = UILabel(frame: frame)
               label.text = text
               label.textAlignment = .center
               label.textColor = .white
               label.numberOfLines = 0
               label.font = UIFont.boldSystemFont(ofSize: fontSize)
               return label
           }
}
  
