//
//  JsonAppsFeed.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/15.
//  Copyright © 2020 Mia. All rights reserved.
//

import Foundation

struct JsonAppsFeed: Decodable {
    let feed: JsonFeed
}

struct JsonFeed: Decodable {
    let title: String
    var results: [JsonFeedResult]
}

struct JsonFeedResult: Decodable {
    let name, artistName, artworkUrl100, id: String
}
