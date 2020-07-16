//
//  AppIconImageView.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppIconImageView: UIImageView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        widthAnchor.constraint(equalToConstant: 64).isActive = true
        heightAnchor.constraint(equalToConstant: 64).isActive = true
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    init(frame: CGRect = .zero, width: CGFloat = 64) {
        super.init(frame: frame)
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: width).isActive = true
        layer.cornerRadius = width / 6
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
