//
//  AppsHorizontalController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseCollectionViewController {
    
    let cellId = "AppsHorizontalController"
    
    let paddingForTopAndBottom: CGFloat = 12
    let paddingForLeft: CGFloat = 12
    let lineSpacing: CGFloat = 10
    let cellWidthFactor: CGFloat = 0.95
    
    var appResults: [JsonFeedResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsSectionCell.self, forCellWithReuseIdentifier: cellId)
        
        // must cast to UICollectionViewFlowLayout to change the scrollDirection
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsSectionCell
        cell.app = appResults?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2*paddingForTopAndBottom - 2*lineSpacing) / 3
        let width = (view.frame.width - paddingForLeft) * cellWidthFactor
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: paddingForTopAndBottom, left: paddingForLeft, bottom: paddingForTopAndBottom, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}
