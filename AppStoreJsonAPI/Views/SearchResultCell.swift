//
//  SearchResultCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/10.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "artist"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.5M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    let screenshotViews: [UIImageView] = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        let infoStackView = UIStackView(arrangedSubviews: [
            nameLabel, artistLabel, ratingLabel
        ])
        infoStackView.axis = .vertical
        
        let overallStackView = UIStackView(arrangedSubviews: [
            iconImage, infoStackView, getButton
        ])
        overallStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: screenshotViews)
        
        let appCellStackView = UIStackView(arrangedSubviews: [
            overallStackView, screenshotsStackView
        ])
        addSubview(appCellStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
