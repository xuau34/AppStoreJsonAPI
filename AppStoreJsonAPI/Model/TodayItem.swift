//
//  TodayItem.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/21.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    var image: UIImage?
    let description: String
    let backgroundColor: UIColor
    
    let todayCellType: TodayCellType
    
    let appResults: [JsonFeedResult]
    
    enum TodayCellType: String {
        case single, multiple
    }
}
