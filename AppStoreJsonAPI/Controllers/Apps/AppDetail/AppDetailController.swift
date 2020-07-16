//
//  AppDetailController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppDetailController: BaseCollectionViewController {
    
    private let dispatchGroup = DispatchGroup()
    
    var appId: String? {
        didSet{
            guard let appId = self.appId else { return }
            
            dispatchGroup.enter()
            let appUrlString = "https://itunes.apple.com/lookup?id=\(appId)"
            Service.shared.fetchJSONData(urlString: appUrlString, completion:{ (results: JsonAppResults?, err) in
                if let err = err {
                    print("Failed on getting app inside AppDetailcontroller:", err)
                    return
                }
                self.app = results?.results.first
                self.dispatchGroup.leave()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
            
            dispatchGroup.enter()
            let reviewUrlString = "https://itunes.apple.com/us/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json"
            Service.shared.fetchJSONData(urlString: reviewUrlString, completion:{ (reviews: JsonReviews?, err) in
                if let err = err {
                    print("Failed on getting app inside AppDetailcontroller:", err)
                    return
                }
                self.reviews = reviews
                self.dispatchGroup.leave()
            })
            
            dispatchGroup.notify(queue: .main, execute: {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
    }
    var app: JsonApp?
    var reviews: JsonReviews?
    
    let detailCellId = "AppDetailControllerDetailCellId"
    let screenShotsCellId = "AppDetailControllerScreenShotsCellId"
    let reviewsCellId = "AppDetailControllerReviewsCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(UpperDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(ScreenShotsGroupCell.self, forCellWithReuseIdentifier: screenShotsCellId)
        collectionView.register(ReviewsGroupCell.self, forCellWithReuseIdentifier: reviewsCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! UpperDetailCell
            cell.app = app
            return cell
        } else  if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotsCellId, for: indexPath) as! ScreenShotsGroupCell
            cell.horizontalController.screenShotUrls = app?.screenshotUrls
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCellId, for: indexPath) as! ReviewsGroupCell
            cell.horizontalController.reviews = self.reviews?.feed.entry
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 280
        if indexPath.item == 0{
            let dummyCell = UpperDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000) )
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        }else if indexPath.item == 1 {
            height = 500
        }
        return .init(width: view.frame.width, height: height)
    }
}
