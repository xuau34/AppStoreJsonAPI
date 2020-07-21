//
//  UIImageView+.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/21.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
