//
//  SnappingCollectionViewController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class SnappingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    init() {
        //Open your eyes!!!
        super.init(collectionViewLayout: SnappingCollectionViewLayout())
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
