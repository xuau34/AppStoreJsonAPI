//
//  TodayController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/17.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController {
    
    let cellId = "TodayControllerCellId"
    
    override func viewWillAppear(_ animated: Bool) {
        // doesn't work in viewDidLoad
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .init(white: 0.8, alpha: 0.5)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
