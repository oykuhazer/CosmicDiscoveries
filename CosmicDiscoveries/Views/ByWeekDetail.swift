//
//  ByWeekDetail.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 16.08.2023.
//

import UIKit
import Combine

class ByWeekDetail: UIViewController {
    
    var article: Article! //The selected article to display
    var viewModel: ByWeekDetailViewModel!
    
        private var cancellables: Set<AnyCancellable> = []
        
        lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = .white
            return label
        }()
        
        lazy var urlLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .white
            label.textAlignment = .center
            label.numberOfLines = 0
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openURL)))
            return label
        }()
        
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = .lightGray
            imageView.clipsToBounds = true
            imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            return imageView
        }()
        
        lazy var newsSiteLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .lightGray
            label.numberOfLines = 0
            return label
        }()
        
        lazy var publishedLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .lightGray
            return label
        }()
        
        lazy var summaryLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 0
            label.textColor = .white
            label.textAlignment = .justified
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //Initialize ViewModel with the selected article
            viewModel = ByWeekDetailViewModel(article: article)
                   setupUI()
        }
        
        func setupUI() {
            view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            
            let views: [UIView] = [titleLabel, UIView(), imageView, urlLabel, newsSiteLabel, publishedLabel, summaryLabel]
            
            views.forEach { stackView.addArrangedSubview($0) }
            
            view.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
            
            titleLabel.text = viewModel.articleDetail.article.title
            urlLabel.text = "Click for more information"
            newsSiteLabel.text = "News Site: \(viewModel.articleDetail.article.newsSite)"
            publishedLabel.text = "Published: \(viewModel.formatDate(viewModel.articleDetail.article.publishedAt))"
            summaryLabel.text = "\(viewModel.articleDetail.article.summary)"
            
            //Load and set the article image
            viewModel.loadImage { [weak self] image in
                self?.imageView.image = image
            }
        }
    //Format and convert the date string
        func formatDate(_ dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "MMM d, yyyy - HH:mm"
                return dateFormatter.string(from: date)
            }
            return ""
        }
        
        @objc func openURL() {
            viewModel.openURL()
        }
    }
