//
//  ReviewsCollectionController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class ReviewsCollectionController: SnappingCollectionViewController {
    let cellId = "ReviewsCollectionControllerCellId"
    
    var reviews: [JsonReviewEntry]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ReviewsCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewsCell
        cell.entry = reviews?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width * 0.9, height: view.frame.height)
    }
}
