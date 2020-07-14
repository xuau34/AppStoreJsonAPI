//
//  SearchResultCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/10.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    var app: JsonApp? {
        didSet{
            guard let app = app else { return }
            let iconUrl = URL(string: app.artworkUrl512)
            iconImage.sd_setImage(with: iconUrl)
            nameLabel.text = app.trackName
            categoryLabel.text = app.primaryGenreName
            ratingLabel.text = String(app.averageUserRatingForCurrentVersion)
            
            for index in (0..<3){
                if index >= app.screenshotUrls.count {
                    break
                }
                let screenshotUrl = URL(string: app.screenshotUrls[index])
                screenshotViews[index].sd_setImage(with: screenshotUrl)
            }
        }
    }
    
    let iconImage = AppIconImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.textColor = .black
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "category"
        label.textColor = .black
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.5M"
        label.textColor = .gray
        return label
    }()
    
    let getButton = GetButton()
    
    lazy var screenshotViews = self.createScreenshotViews()
    
    private func createScreenshotViews() -> [UIImageView] {
        var views = [UIImageView]()
        for _ in (0..<3) {
            let view = UIImageView()
            view.clipsToBounds = true
            view.layer.cornerRadius = 4
            view.layer.borderWidth = 0.8
            view.layer.borderColor = CGColor(genericGrayGamma2_2Gray: 0.5, alpha: 0.5)
            views.append(view)
        }
        return views
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let infoStackView = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingLabel
        ])
        infoStackView.axis = .vertical
        let overallStackView = UIStackView(arrangedSubviews: [
            iconImage, infoStackView, getButton
        ])
        overallStackView.spacing = 12
        overallStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: screenshotViews )
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let appCellStackView = UIStackView(arrangedSubviews: [
            overallStackView, screenshotsStackView
        ])
        appCellStackView.spacing = 16
        appCellStackView.axis = .vertical
        
        // addSubview must be in front of .translatesAuto... and .constraint, for those need to set in between the hooker, the view, and itself to emit an object
        addSubview(appCellStackView)
        appCellStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        appCellStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
