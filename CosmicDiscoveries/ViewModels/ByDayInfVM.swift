//
//  ByDayInfVM.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 23.08.2023.
//

import Foundation
import UIKit
import Combine
import Alamofire

class APODViewModel {
    //Set to keep track of the active network requests
      private var cancellables: Set<AnyCancellable> = []
          
      //Function to fetch APOD data for a given date
      func fetchAPOD(for date: Date) -> AnyPublisher<APODModel, Never> {
          let apiKey = "3Md88pudNVfvpnN9gfxjHoQBKqM6yfAL6HTcCw5F"
          let apodURL = "https://api.nasa.gov/planetary/apod"
          
          //Create a date formatter to convert the selected date into the required format
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          let selectedDate = dateFormatter.string(from: date)
          
          //Set up parameters for the API request
          let parameters: [String: Any] = [
              "date": selectedDate,
              "api_key": apiKey
          ]
          
          //Initiate the network request using Alamofire (AF)
          return AF.request(apodURL, method: .get, parameters: parameters)
              .publishDecodable(type: APODResponse.self) //Decode the response into APODResponse type
              .compactMap { $0.value } //Unwrap the optional value from the response
              .map { apodResponse in
                  //Map the APODResponse to your custom APODModel
                  APODModel(title: apodResponse.title,
                            explanation: apodResponse.explanation,
                            mediaType: apodResponse.mediaType,
                            hdURL: apodResponse.hdURL)
              }
              .replaceError(with: APODModel(title: "Error", explanation: "Failed to fetch data.", mediaType: "", hdURL: ""))
              .receive(on: DispatchQueue.main) 
              .eraseToAnyPublisher() //Convert the result to AnyPublisher type
      }
  }
