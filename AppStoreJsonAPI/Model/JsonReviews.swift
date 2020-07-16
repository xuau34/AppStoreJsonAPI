//
//  JsonReviewsFeed.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import Foundation

struct JsonReviews: Decodable {
    let feed: JsonReviewsFeed
}

struct JsonReviewsFeed: Decodable {
    var entry: [JsonReviewEntry]?
}

struct JsonReviewEntry: Decodable {
    let author: JsonReviewAuthor
    let title: JsonReviewLabel
    let content: JsonReviewLabel
    let rating: JsonReviewLabel
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct JsonReviewAuthor: Decodable {
    let name: JsonReviewLabel
}

struct JsonReviewLabel: Decodable {
    let label: String
}
