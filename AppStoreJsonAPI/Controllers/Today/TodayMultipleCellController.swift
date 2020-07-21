//
//  TodayMultipleCellController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/21.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class TodayMultipleCellController: BaseCollectionViewController {
    let cellId = "TodayMultipleCellControllerCellId"
    
    var appResults = [JsonFeedResult]()
    let itemSpacing: CGFloat = 16
    
    override var prefersStatusBarHidden: Bool { return true } // not working
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside )
        return button
    }()
    
    let mode: Mode

    enum Mode {
        case small, fullScreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        
        if mode == .fullScreen {
            collectionView.addSubview(cancelButton)
            cancelButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 12), size: .init(width: 44, height: 44))
        }
        // Never fetch data from a view nor from a sub controller - important!
        /*
        Service.shared.fetchFeed(category: "new-games-we-love", allGenre: true, limit: 12, explicit: true, completion: { resultFeed, err in
            if let err = err {
                print("Failed on fetching feed:", err)
                return
            }
            guard let results = resultFeed?.feed.results else { return }
            DispatchQueue.main.async {
                self.appResults = results
                self.collectionView.reloadData()
            }
        })
         */
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .small {
            return min(4, appResults.count)
        }
        return appResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 76
        var width: CGFloat = collectionView.frame.width
        if mode == .small {
            height = (collectionView.frame.height - 3*itemSpacing)/4
        } else {
            width -= 48
        }
        return .init(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayMultipleAppCell
        cell.app = appResults[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .small {
            return .zero
        }
        return .init(top: 60, left: 24, bottom: 12, right: 24)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = AppDetailController(appId: appResults[indexPath.item].id )
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
