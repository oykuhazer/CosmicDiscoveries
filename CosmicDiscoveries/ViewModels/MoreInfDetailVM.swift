//
//  MoreInfDetailVM.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 23.08.2023.
//


import Foundation
import UIKit
import Combine
import Alamofire


class MoreInfDetailViewModel {
    //Property to hold the detailed data of the selected item
      var detailData: DetailData?
      
      //Function to fetch detailed data for a selected title
      func fetchData(for selectedTitle: String, completion: @escaping (DetailData?) -> Void) {
          //Format the selected title for use in the API URL
          let formattedTitle = selectedTitle.replacingOccurrences(of: " ", with: "%20")
          let apiUrl = "https://images-api.nasa.gov/search?q=\(formattedTitle)"
          
          AF.request(apiUrl).responseJSON { response in
              switch response.result {
              case .success(let value):
                  if let json = value as? [String: Any],
                     let collection = json["collection"] as? [String: Any],
                     let items = collection["items"] as? [[String: Any]],
                     let firstItem = items.first,
                     let data = firstItem["data"] as? [[String: Any]],
                     let firstData = data.first,
                     let description = firstData["description"] as? String,
                     let creator = firstData["center"] as? String,
                     let dateCreated = firstData["date_created"] as? String,
                     let previewLink = firstItem["links"] as? [[String: Any]],
                     let imageUrl = previewLink.first?["href"] as? String {
                      let detail = DetailData(description: description,
                                              creator: "Creator: \(creator)",
                                              dateCreated: "Date Created: \(dateCreated)",
                                              imageUrl: imageUrl)
                      self.detailData = detail
                      completion(detail)
                  } else {
                      completion(nil)
                  }
              case .failure(let error):
                  print("API Error: \(error)")
                  completion(nil)
              }
          }
      }
      
      //Function to load an image from a given URL
      func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
          if let url = URL(string: urlString) {
              //Initiate a network request to load the image data
              AF.request(url).responseData { response in
                  switch response.result {
                  case .success(let data):
                      if let image = UIImage(data: data) {
                          completion(image)
                      } else {
                          completion(nil)
                      }
                  case .failure(let error):
                      print("Image Load Error: \(error)")
                      completion(nil)
                  }
              }
          } else {
              completion(nil)
          }
      }
  }
