//
//  ReviewsGroupCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class ReviewsGroupCell: UICollectionViewCell {
    
    let reviewsLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    let horizontalController = ReviewsCollectionController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewsLabel)
        reviewsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: reviewsLabel.bottomAnchor, leading: reviewsLabel.leadingAnchor, bottom: bottomAnchor, trailing: reviewsLabel.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 20, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
