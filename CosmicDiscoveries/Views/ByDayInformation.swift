//
//  ByDayInformation.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 16.08.2023.
//

import UIKit
import Alamofire
import Combine

class ByDayInformation: UIViewController {
    
    private var viewModel = APODViewModel()
       
       private var mainTitleLabel: UILabel!
       private var imageView: UIImageView!
       private var titleLabel: UILabel!
       private var explanationTextView: UITextView!
       private var datePicker: UIDatePicker!
       private var likeButton: UIButton!
       
       private var cancellables: Set<AnyCancellable> = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           view.backgroundColor = UIColor(red: 28/255, green: 61/255, blue: 121/255, alpha: 1.0)
           setupUI()
           fetchAndUpdateAPOD(for: Date())
           
           let favListButton = UIBarButtonItem(title: "Fav List", style: .plain, target: self, action: #selector(goToDetailButtonTapped))
           navigationItem.rightBarButtonItem = favListButton
       }
         
       private func setupUI() {
           mainTitleLabel = UILabel()
           mainTitleLabel.text = "Discovering the Cosmos Today"
           mainTitleLabel.textColor = UIColor(white: 0.95, alpha: 1.0)
           mainTitleLabel.textAlignment = .center
           mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
           mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(mainTitleLabel)
           
           imageView = UIImageView()
           imageView.contentMode = .scaleAspectFit
           imageView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(imageView)
           
           titleLabel = UILabel()
           titleLabel.textColor = UIColor(white: 0.95, alpha: 1.0)
           titleLabel.textAlignment = .center
           titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(titleLabel)
           
           explanationTextView = UITextView()
           explanationTextView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
           explanationTextView.textColor = UIColor(white: 0.85, alpha: 1.0)
           explanationTextView.textAlignment = .justified
           explanationTextView.font = UIFont.systemFont(ofSize: 14)
           explanationTextView.isScrollEnabled = true
           explanationTextView.isEditable = false
           explanationTextView.translatesAutoresizingMaskIntoConstraints = false
           explanationTextView.layer.cornerRadius = 10
           explanationTextView.layer.masksToBounds = true
           view.addSubview(explanationTextView)
           
           datePicker = UIDatePicker()
           datePicker.datePickerMode = .date
           datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
           datePicker.backgroundColor = UIColor(white: 0.5, alpha: 1.0)
           datePicker.setValue(UIColor(white: 0.2, alpha: 1.0), forKeyPath: "textColor")
           datePicker.layer.cornerRadius = 10
           datePicker.layer.masksToBounds = true
           datePicker.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(datePicker)
           
           likeButton = UIButton(type: .custom)
           likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
           likeButton.tintColor = .red
           likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
           likeButton.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(likeButton)
           
           NSLayoutConstraint.activate([
               mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
               mainTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               
               imageView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20),
               imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               imageView.widthAnchor.constraint(equalToConstant: 300),
               imageView.heightAnchor.constraint(equalToConstant: 300),
               
               titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
               titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               
               datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23),
               
               explanationTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
               explanationTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               explanationTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               explanationTextView.heightAnchor.constraint(equalToConstant: 200),
               
               likeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
               likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               likeButton.widthAnchor.constraint(equalToConstant: 30),
               likeButton.heightAnchor.constraint(equalToConstant: 30)
           ])
       }
    
    //Fetch APOD data for a specific date and update the UI
    private func fetchAndUpdateAPOD(for date: Date) {
        viewModel.fetchAPOD(for: date)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] apodData in
                self?.updateUI(with: apodData)
            }
            .store(in: &cancellables)
    }
    
    //Action when the "Like" button is tapped
    @objc private func likeButtonTapped(_ sender: UIButton) {
        let selectedDate = datePicker.date
        saveEntryToUserDefaults(date: selectedDate)
    }
    
    // Save entry to UserDefaults
    private func saveEntryToUserDefaults(date: Date) {
        var savedDates = UserDefaults.standard.array(forKey: "savedDates") as? [Date] ?? []
        savedDates.append(date)
        UserDefaults.standard.set(savedDates, forKey: "savedDates")
    }
    
    //Action when the "Fav List" button is tapped
    @objc private func goToDetailButtonTapped() {
        let detailVC = FavList()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //Action when the DatePicker value changes
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        fetchAndUpdateAPOD(for: sender.date)
    }
    
    //Update UI with APOD data
    private func updateUI(with apodData: APODModel) {
        titleLabel.text = apodData.title
        explanationTextView.text = apodData.explanation
        
        //Load and display image if the media type is an image
        if apodData.mediaType == "image", let imageURL = URL(string: apodData.hdURL) {
            AF.download(imageURL).responseData { response in
                if let data = response.value {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
