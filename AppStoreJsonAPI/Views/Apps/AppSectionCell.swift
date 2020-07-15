//
//  AppSectionCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppSectionCell: UICollectionViewCell {
    
    let appSectionLabel = UILabel(text: "App Section", font: UIFont.boldSystemFont(ofSize: 20))
    
    let horizontalController = AppsHorizontalController()
    
    var appFeed: JsonAppsFeed? {
        didSet{
            appSectionLabel.text = appFeed?.feed.title
            horizontalController.appResults = appFeed?.feed.results
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appSectionLabel)
        appSectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: appSectionLabel.bottomAnchor, leading: leadingAnchor, bottom:  bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
