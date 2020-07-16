//
//  AppsHeaderHorizontalController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: SnappingCollectionViewController {
    
    let cellId = "AppsHeaderHorizontalControllerCellId"
    let paddingForLeft: CGFloat = 12
    let paddingForBottom: CGFloat = 12
    let widthFactor: CGFloat = 0.95
    
    var socialFeeds: [JsonSocialFeed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: paddingForLeft, bottom: paddingForBottom, right: 0)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialFeeds?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
        cell.feed = socialFeeds?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - paddingForLeft) * widthFactor
        return .init(width: width, height: view.frame.height - paddingForBottom)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: paddingForBottom, right: 0)
    }
    */
}
