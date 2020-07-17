//
//  TodayCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/17.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: .init(imageLiteralResourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.constrainWidth(constant: 280)
        imageView.constrainHeight(constant: 280)
        imageView.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
