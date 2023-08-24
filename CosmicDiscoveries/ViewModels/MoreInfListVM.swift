//
//  MoreInfListMV.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 23.08.2023.
//

import Foundation
import UIKit
import Combine
import Alamofire


class MoreInfListViewModel {
    //Published property to hold the sections, automatically updating its subscribers
       @Published var sections: [String] = []
       
       //Published property to hold titles grouped by section, automatically updating its subscribers
       @Published var titlesBySection: [String: [String]] = [:]
       
       //Published property to track whether a section is expanded or collapsed, automatically updating its subscribers
       @Published var sectionIsExpanded: [Bool] = []
       
       init() {
           //Initialize sectionIsExpanded array with the same count as sections, all initially collapsed
           sectionIsExpanded = Array(repeating: false, count: sections.count)
       }

func fetchTitles() {
    let apiUrls: [String] = [
        
        "https://images-api.nasa.gov/search?q=space%20stations",
        "https://images-api.nasa.gov/search?q=spacecraft%20images",
        "https://images-api.nasa.gov/search?q=sun",
        "https://images-api.nasa.gov/search?q=stars",
        "https://images-api.nasa.gov/search?q=galaxies",
        "https://images-api.nasa.gov/search?q=black%20holes",
        "https://images-api.nasa.gov/search?q=star%20formation",
        "https://images-api.nasa.gov/search?q=supernovae",
        "https://images-api.nasa.gov/search?q=dark%20matter%20and%20energy",
        "https://images-api.nasa.gov/search?q=black%20hole%20collisions",
        "https://images-api.nasa.gov/search?q=black%20holes%20and%20galaxy%20formation",
        "https://images-api.nasa.gov/search?q=exoplanets",
        "https://images-api.nasa.gov/search?q=astrobiology%20and%20origin%20of%20life",
       "https://images-api.nasa.gov/search?q=solar%20eclipses%20and%20observation%20events",
        "https://images-api.nasa.gov/search?q=solar%20flares%20and%20activity",
        "https://images-api.nasa.gov/search?q=sun%20surface%20and%20atmosphere",
        "https://images-api.nasa.gov/search?q=time%20dilation%20and%20black%20holes",
        "https://images-api.nasa.gov/search?q=time%20travel%20and%20black%20holes",
        "https://images-api.nasa.gov/search?q=black%20holes%20and%20effects%20on%20past%20present%20and%20future"
]
    
    //Loop through each API URL to fetch titles
          for apiUrl in apiUrls {
              AF.request(apiUrl).responseJSON { [weak self] response in
                  guard let self = self else { return }
                  
                  switch response.result {
                  case .success(let value):
                      if let json = value as? [String: Any],
                          let collection = json["collection"] as? [String: Any],
                          let items = collection["items"] as? [[String: Any]] {
                          
                          var titlesForSection: [String] = []
                          for item in items {
                              if let data = item["data"] as? [[String: Any]],
                                 let firstData = data.first,
                                 let title = firstData["title"] as? String {
                                  titlesForSection.append(title)
                              }
                              if titlesForSection.count >= 10 {
                                  break
                              }
                          }
                          
                          //Extract the section name from the API URL and add data to properties
                          let section = apiUrl.components(separatedBy: "q=").last ?? "Other"
                          self.sections.append(section)
                          self.titlesBySection[section] = titlesForSection
                          self.sectionIsExpanded.append(false)
                      }
                  case .failure(let error):
                      print("Failure: \(error)")
                  }
              }
          }
      }
  }
