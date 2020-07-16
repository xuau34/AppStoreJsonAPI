//
//  SceenShotsCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class ScreenShotsGroupCell: UICollectionViewCell {
    
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    let horizontalController = ScreenShotsCollectionController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(previewLabel)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: previewLabel.leadingAnchor, bottom: bottomAnchor, trailing: previewLabel.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 20, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
