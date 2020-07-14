//
//  GetButton.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class GetButton: UIButton {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setTitle("GET", for: .normal)
        setTitleColor(UIColor(red: 64/255, green: 144/255, blue: 186/255, alpha: 1) , for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 14)
        backgroundColor = UIColor.init(cgColor: CGColor(genericGrayGamma2_2Gray: 0.75, alpha: 0.3))
        widthAnchor.constraint(equalToConstant: 80).isActive = true
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        layer.cornerRadius = 32/2.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
