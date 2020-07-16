//
//  BaseCollectionViewController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

// the delegate is important to let flowLayout know the parameters, in order to change the flow
class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    init() {
        //Open your eyes!!!
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
