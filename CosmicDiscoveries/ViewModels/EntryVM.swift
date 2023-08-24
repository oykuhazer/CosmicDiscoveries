//
//  EntryVM.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 23.08.2023.
//

import Foundation
import UIKit
import Combine


class SpaceViewModel {
    //Array to hold space items
     private(set) var spaceItems: [SpaceItem] = [] {
         didSet {
             //Callback to notify data update
             onDataUpdate?()
         }
     }

     //Callback closure for data update
     var onDataUpdate: (() -> Void)?

     //Fetch space items from a data source (simulated here)
     func fetchSpaceItems() {
         //Simulated space items
         let simulatedSpaceItems = [
             SpaceItem(title: "Everyday New Information"),
             SpaceItem(title: "Weekly Articles"),
             SpaceItem(title: "More Information")
         ]
         //Assign simulated data to spaceItems
         spaceItems = simulatedSpaceItems
     }

     //Get a space item at a specific index
     func spaceItem(at index: Int) -> SpaceItem {
         return spaceItems[index]
     }
 }
