//
//  TodayCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/17.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCollectionViewCell {
    
    override var todayItem: TodayItem? {
        didSet{
            categoryLabel.text =  todayItem?.category
            titleLabel.text = todayItem?.title
            imageView.image = todayItem?.image
            descriptionLabel.text = todayItem?.description
            backgroundColor = todayItem?.backgroundColor
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 16))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 20))
    let imageView = UIImageView(image: .init(imageLiteralResourceName: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    var topConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        let imageContainer = UIView()
        imageContainer.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 230, height: 230))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, imageContainer, descriptionLabel
        ], spacing: 12)
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
