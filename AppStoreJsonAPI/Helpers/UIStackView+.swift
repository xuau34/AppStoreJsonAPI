//
//  UIStackView+.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0){
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
