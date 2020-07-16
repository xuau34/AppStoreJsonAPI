//
//  JsonAppResults.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import Foundation

struct JsonAppResults: Decodable {
    let resultCount: Int
    var results: [JsonApp]
}

struct JsonApp: Decodable{
    let artworkUrl512: String //iconUrl
    let trackName: String   //appName
    let artistName: String
    let primaryGenreName: String    //category
    let averageUserRatingForCurrentVersion: Float   //rating
    var screenshotUrls: [String]  //[same]
    var releaseNotes: String
    var description: String
    var formattedPrice: String
}
