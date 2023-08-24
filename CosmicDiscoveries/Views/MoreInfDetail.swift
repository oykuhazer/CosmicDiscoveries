//
//  MoreInfDetail.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 16.08.2023.
//

import UIKit
import Alamofire

class MoreInfDetail: UIViewController {
    var viewModel = MoreInfDetailViewModel()
     
     var titleLabel: UILabel!
     var imageView: UIImageView!
     var dateLabel: UILabel!
     var creatorLabel: UILabel!
     var descriptionTextView: UITextView!
     
     var selectedTitle: String? //Holds the selected title

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = UIColor(red: 5/255, green: 10/255, blue: 25/255, alpha: 1.0)
         
         titleLabel = UILabel()
         titleLabel.textAlignment = .center
         titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
         titleLabel.numberOfLines = 0
         titleLabel.textColor = UIColor(red: 0/255, green: 173/255, blue: 239/255, alpha: 1.0)
         view.addSubview(titleLabel)

         imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         view.addSubview(imageView)

         dateLabel = UILabel()
         dateLabel.textAlignment = .center
         dateLabel.font = UIFont.systemFont(ofSize: 14)
         dateLabel.textColor = .white
         view.addSubview(dateLabel)

         creatorLabel = UILabel()
         creatorLabel.textAlignment = .center
         creatorLabel.font = UIFont.systemFont(ofSize: 14)
         creatorLabel.textColor = .white
         view.addSubview(creatorLabel)

         descriptionTextView = UITextView()
         descriptionTextView.textAlignment = .center
         descriptionTextView.font = UIFont.systemFont(ofSize: 14)
         descriptionTextView.backgroundColor = .darkGray
         descriptionTextView.textColor = .white
         descriptionTextView.isEditable = false
         descriptionTextView.isScrollEnabled = false
         view.addSubview(descriptionTextView)

         setupLayout()
         
         //Set selected title to the titleLabel
                 titleLabel.text = selectedTitle
                 
                 //Fetch data and update UI if a title is selected
                 if let selectedTitle = selectedTitle {
                     viewModel.fetchData(for: selectedTitle) { [weak self] detailData in
                         if let detailData = detailData {
                             self?.updateUI(with: detailData)
                         }
                     }
                 }
             }
     
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false

        let margin: CGFloat = 30

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -2 * margin),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin),
            
            creatorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creatorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: margin),
            
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: creatorLabel.bottomAnchor, constant: margin),
            descriptionTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -2 * margin),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    //Update UI with data from the ViewModel
    func updateUI(with detailData: DetailData) {
            viewModel.loadImage(from: detailData.imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.descriptionTextView.text = detailData.description
                    self?.creatorLabel.text = detailData.creator
                    self?.dateLabel.text = detailData.dateCreated
                    self?.imageView.image = image
                }
            }
        }
 }
