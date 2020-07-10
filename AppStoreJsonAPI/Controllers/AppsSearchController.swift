//
//  AppsSearchControllerCollectionViewController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/10.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {
    
    //let appIcon:
    private let cellId = "AppsSearchControllerCellId"
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .green
        cell.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        return cell
    }
    
    /*
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
 */
    
}
