//
//  Models.swift
//  CosmicDiscoveries
//
//  Created by Öykü Hazer Ekinci on 19.08.2023.
//

import Foundation
import UIKit


//Entry
struct SpaceItem {
    let title: String
}


//ByDayInformation
struct APODModel {
    let title: String
    let explanation: String
    let mediaType: String
    let hdURL: String
}

struct APODResponse: Decodable {
    let title: String
    let explanation: String
    let mediaType: String
    let hdURL: String

    private enum CodingKeys: String, CodingKey {
        case title, explanation, mediaType = "media_type", hdURL = "hdurl"
    }
}


//ByWeekInfList
struct Article: Codable {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String?
    let newsSite: String
    let summary: String
    let publishedAt: String
    let updatedAt: String
    let featured: Bool
}


//ByWeekDetail
struct ArticleDetail {
    let article: Article
    var image: UIImage?
}


//MoreInfDetail
struct DetailData {
    let description: String
    let creator: String
    let dateCreated: String
    let imageUrl: String
}

