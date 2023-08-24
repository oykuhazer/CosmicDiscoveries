//
//  ByWeekDetailMV.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 23.08.2023.
//

import Foundation
import UIKit
import Combine
import Alamofire

class ByWeekDetailViewModel {
    //Set to keep track of the active network requests
     private var cancellables: Set<AnyCancellable> = []
     
     //Published property to hold the article detail, automatically updating its subscribers
     @Published var articleDetail: ArticleDetail
     
     //Initialize the ViewModel with an article, setting up the article detail
     init(article: Article) {
         self.articleDetail = ArticleDetail(article: article)
     }
     
     //Function to load the article's image from its URL
     func loadImage(completion: @escaping (UIImage?) -> Void) {
         if let imageUrl = articleDetail.article.imageUrl, let url = URL(string: imageUrl) {
             //Initiate a network request to fetch the image data
             URLSession.shared.dataTaskPublisher(for: url)
                 .map(\.data)
                 .map { UIImage(data: $0) }
                 .replaceNil(with: UIImage(named: "placeholderImage"))
                 .receive(on: DispatchQueue.main) //Receive and handle the result on the main queue
                 .sink(receiveCompletion: { completion in
                     //This closure is called when the image loading completes or fails
                 }, receiveValue: { image in
                     completion(image)
                 })
                 .store(in: &cancellables) //Store the network request's publisher in the cancellables set
         }
     }
     
     //Format a date string into a more readable format
     func formatDate(_ dateString: String) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
         if let date = dateFormatter.date(from: dateString) {
             dateFormatter.dateFormat = "MMM d, yyyy - HH:mm"
             return dateFormatter.string(from: date)
         }
         return ""
     }
     
     //Open the URL associated with the article
     func openURL() {
         if let url = URL(string: articleDetail.article.url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
     }
 }
