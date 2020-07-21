//
//  TodayMultipleCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/21.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class TodayMultipleCell: BaseTodayCollectionViewCell {
    
    override var todayItem: TodayItem? {
        didSet{
            categoryLabel.text =  todayItem?.category
            titleLabel.text = todayItem?.title
            multipleCollectionViewController.appResults = todayItem?.appResults ?? []
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 16))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    
    
    let multipleCollectionViewController = TodayMultipleCellController(mode: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, multipleCollectionViewController.collectionView
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
