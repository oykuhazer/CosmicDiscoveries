//
//  FavListVM.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 23.08.2023.
//

import Foundation
import UIKit
import Combine
import Alamofire


class FavListViewModel {
    //Array to store the saved dates, saving to UserDefaults whenever it's updated
      private var savedDates: [Date] = [] {
          didSet {
              UserDefaults.standard.set(savedDates, forKey: "savedDates")
          }
      }

      //Number of rows in the list corresponds to the count of saved dates
      var numberOfRows: Int {
          return savedDates.count
      }

      //Initialize the ViewModel and fetch saved dates from UserDefaults
      init() {
          fetchSavedDates()
      }

      //Get the formatted date string for a specific row at the given index path
      func dateStringForRow(at indexPath: IndexPath) -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = .medium
          return dateFormatter.string(from: savedDates[indexPath.row])
      }

      func backgroundColorForRow(at indexPath: IndexPath) -> UIColor {
          return indexPath.row % 2 == 0 ?
              UIColor(red: 28/255, green: 61/255, blue: 121/255, alpha: 1.0) :
              UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
      }

      func textColorForRow(at indexPath: IndexPath) -> UIColor {
          return indexPath.row % 2 == 0 ?
              UIColor(white: 0.95, alpha: 1.0) :
              UIColor(white: 0.2, alpha: 1.0)
      }

      //Remove a saved date at a specific index path
      func deleteDate(at indexPath: IndexPath) {
          savedDates.remove(at: indexPath.row)
          
          //Notify observers that the saved dates list has been updated
          NotificationCenter.default.post(name: NSNotification.Name("SavedDatesUpdated"), object: nil)
      }

      //Add a new date to the saved dates list
      func addDate(_ date: Date) {
          savedDates.append(date)
          
          //Notify observers that the saved dates list has been updated
          NotificationCenter.default.post(name: NSNotification.Name("SavedDatesUpdated"), object: nil)
      }

      //Fetch saved dates from UserDefaults
      private func fetchSavedDates() {
          if let dates = UserDefaults.standard.array(forKey: "savedDates") as? [Date] {
              savedDates = dates
          }
      }
  }
