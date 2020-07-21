//
//  FullScreenHeaderCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/20.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class FullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayCell()
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.imageView?.tintColor = .blue     // buggy
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(todayCell)
        todayCell.fillSuperview()
        todayCell.layer.cornerRadius = 0
        
        addSubview(cancelButton)
        cancelButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 48, left: 0, bottom: 0, right: 0), size: .init(width: 90, height: 40))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
