//
//  AppsController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/14.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class AppsPageController: BaseCollectionViewController {
    private let cellId = "AppsControllerCellId"
    private let headerId = "AppsControllerHeaderId"
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .black
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()

    private let dispatchGroup = DispatchGroup()
    private let categories = ["new-apps-we-love", "new-games-we-love", "top-free", "top-grossing", "top-paid"]
    private var appFeeds = [JsonAppsFeed]()
    private var socialFeeds: [JsonSocialFeed]?
    
    override func viewDidLoad() {
        collectionView.register(AppSectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.backgroundColor = .white
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchFeeds()
    }
    
    func fetchFeeds() {
        categories.forEach({ category in
            dispatchGroup.enter()
            Service.shared.fetchFeed(category: category, allGenre: true, limit: 12, explicit: true, completion: handleFetchFeed)
        })
        
        dispatchGroup.enter()
        Service.shared.fetchSocialFeed(completion: { socialFeeds in
            self.dispatchGroup.leave()
            self.socialFeeds = socialFeeds
        })
        
        dispatchGroup.notify(queue: .main, execute: {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
            print(self.appFeeds.count)
        })
    }
    
    func handleFetchFeed( appsFeed: JsonAppsFeed ) {
        DispatchQueue.main.async {
            self.appFeeds.append(appsFeed)
        }
        dispatchGroup.leave()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appFeeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppSectionCell
        cell.appFeed = appFeeds[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsHeaderView
        view.headerHorizontalController.socialFeeds = self.socialFeeds
        view.headerHorizontalController.collectionView.reloadData()
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}
