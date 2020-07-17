//
//  UpperDetailCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class UpperDetailCell: UICollectionViewCell {
    
    var app: JsonApp? {
        didSet{
            guard let app = app else { return }
            iconImageView.sd_setImage(with: URL(string: app.artworkUrl512), completed: nil)
            nameLabel.text = app.trackName
            artistLabel.text = app.artistName
            priceButton.setTitle(app.formattedPrice, for: .normal)
            releaseNoteLabel.text = app.releaseNotes
        }
    }
    
    let iconImageView = AppIconImageView(width: 140)
    let nameLabel = UILabel(text: "name", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    let artistLabel = UILabel(text: "artist", font: .systemFont(ofSize: 18))
    let priceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("$4.95", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 32/2
        return button
    }()
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let releaseNoteLabel = UILabel(text: "Release Note", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                iconImageView, VerticalStackView(arrangedSubviews: [
                    nameLabel, artistLabel, UIStackView(arrangedSubviews: [
                        priceButton, UIView()
                    ])
                ], spacing: 8)
            ], customSpacing: 12), whatsNewLabel, releaseNoteLabel
        ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
