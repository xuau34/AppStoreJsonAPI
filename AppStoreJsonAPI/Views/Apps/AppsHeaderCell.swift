//
//  AppsHeaderCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebook", font: UIFont.boldSystemFont(ofSize: 13))
    
    let titleLabel = UILabel(text: "Keeping up with friends is faster.", font: .systemFont(ofSize: 24))
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .red
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 2
        
        let stackView = UIStackView(arrangedSubviews: [
            companyLabel, titleLabel, imageView
        ])
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        stackView.axis = .vertical
        stackView.spacing = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
