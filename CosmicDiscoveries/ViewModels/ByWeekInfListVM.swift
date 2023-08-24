//
//  ByWeekInfListMV.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 23.08.2023.
//

import Foundation
import UIKit
import Combine
import Alamofire

class ByWeekInfListViewModel {
    //Set to keep track of the active network requests
      private var cancellables: Set<AnyCancellable> = []
      
      //Published property to hold the list of articles, automatically updating its subscribers
      @Published var articles: [Article] = []
      
      //Publisher for the articles property, allowing external objects to subscribe for updates
      var articlesPublisher: Published<[Article]>.Publisher { $articles }
      
      func fetchArticles() {
          let apiUrl = "https://api.spaceflightnewsapi.net/v3/articles"
          
          //Initiate a network request using Alamofire (AF)
          AF.request(apiUrl)
              .publishDecodable(type: [Article].self) //Decode the response into an array of Article objects
              .compactMap { $0.value } //Unwrap the optional value from the response
              .receive(on: DispatchQueue.main) //Receive and handle the result on the main queue
              .sink(receiveCompletion: { completion in
                  //This closure is called when the network request completes or fails
              }, receiveValue: { [weak self] articles in
                  //Update the articles property with the fetched articles
                  self?.articles = articles
              })
              .store(in: &cancellables) //Store the network request's publisher in the cancellables set
      }
  }
