//
//  TodayController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/17.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController {
    
    /*
    let todayItems = [
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: UIImage(named: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, todayCellType: .single),
        TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive These CarPlay Apps", image: UIImage(named: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, todayCellType: .multiple),
        TodayItem.init(category: "Holidays", title: "Travel on a Budget", image: UIImage(named: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9841833711, green: 0.9656425118, blue: 0.7242308259, alpha: 1), todayCellType: .single),
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: UIImage(named: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, todayCellType: .multiple)
    ]
    */
    var todayItems = [TodayItem]()
    
    var animationStartFrame: CGRect?
    var animationFullScreenController: FullScreenController?
    var tabBarOriginY: CGFloat?
    var animationTopConstraint: NSLayoutConstraint?
    var animationLeadingConstraint: NSLayoutConstraint?
    var animationWidthConstraint: NSLayoutConstraint?
    var animationHeightConstraint: NSLayoutConstraint?
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: .large)
        av.color = .darkGray
        av.startAnimating()
        av.hidesWhenStopped = true
        return av
    }()
    
    let dispatchGroup = DispatchGroup()
    
    override func viewWillAppear(_ animated: Bool) {
        // doesn't work in viewDidLoad
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .init(white: 0.8, alpha: 0.5)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.TodayCellType.single.rawValue)
        collectionView.register(TodayMultipleCell.self, forCellWithReuseIdentifier: TodayItem.TodayCellType.multiple.rawValue)
        
        
        collectionView.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        fetchData()
    }
    
    func fetchData() {
        var gamesFeed: JsonAppsFeed?
        var topGrossingFeed: JsonAppsFeed?
        
        dispatchGroup.enter()
        Service.shared.fetchFeed(category: "new-games-we-love", allGenre: true, limit: 12, explicit: true, completion: { resultFeed, err in
            if let err = err {
                print("Failed on fetching feed:", err)
                return
            }
            gamesFeed = resultFeed
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Service.shared.fetchFeed(category: "top-grossing", allGenre: true, limit: 12, explicit: true, completion: { resultFeed, err in
            if let err = err {
                print("Failed on fetching feed:", err)
                return
            }
            topGrossingFeed = resultFeed
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            
            self.todayItems = [
                TodayItem.init(category: "Daily List", title: "Editor's Choice Games", image: nil, description: "", backgroundColor: .white, todayCellType: .multiple, appResults: gamesFeed?.feed.results ?? []),
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: UIImage(named: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, todayCellType: .single, appResults: []),
                TodayItem.init(category: "Daily List", title: "Top Grossing iPhone Apps", image: nil, description: "", backgroundColor: .white, todayCellType: .multiple, appResults: topGrossingFeed?.feed.results ?? []),
                TodayItem.init(category: "Holidays", title: "Travel on a Budget", image: UIImage(named: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9841833711, green: 0.9656425118, blue: 0.7242308259, alpha: 1), todayCellType: .single, appResults: [])
            ]
            
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayItems[indexPath.item].todayCellType.rawValue, for: indexPath) as! BaseTodayCollectionViewCell
        cell.todayItem = todayItems[indexPath.item]
        
        // because at top, it's multipleCollectionViewController
        //cell.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleTapApp)))
        (cell as? TodayMultipleCell)?.multipleCollectionViewController.collectionView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleTapApp)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if todayItems[indexPath.item].todayCellType == .single {
            return .init(width: view.frame.width - 64, height: 450)
        }
        return .init(width: view.frame.width - 64, height: 475)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if todayItems[indexPath.item].todayCellType == .multiple {
            presentFullScreenAppController(indexPath: indexPath)
            return
        }
        
        let fullScreenController = FullScreenController()
        fullScreenController.fullScreenHeaderCell.cancelButton.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleCellCancel)))
        fullScreenController.fullScreenHeaderCell.todayCell.todayItem = todayItems[indexPath.item]
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        guard let view = fullScreenController.view else { return }
        
        view.frame = startFrame
        self.animationStartFrame = startFrame
        self.view.addSubview(view)
        view.layer.cornerRadius = 16
        addChild(fullScreenController)
        self.animationFullScreenController = fullScreenController
        self.tabBarOriginY = self.tabBarController?.tabBar.frame.origin.y
        
        //using view.frame to animate is not entirely reliable, so the better way is with auto layout constraints
        view.translatesAutoresizingMaskIntoConstraints = false
        animationTopConstraint = view.topAnchor.constraint(equalTo: self.view.topAnchor ,constant: startFrame.origin.y)
        animationLeadingConstraint = view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor ,constant: startFrame.origin.x)
        animationWidthConstraint = view.widthAnchor.constraint(equalToConstant: startFrame.width)
        animationHeightConstraint = view.heightAnchor.constraint(equalToConstant: startFrame.height)
        [animationTopConstraint, animationLeadingConstraint, animationWidthConstraint, animationHeightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()   //to force it to execute the layout
        
        self.collectionView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.animationTopConstraint?.constant = 0
            self.animationLeadingConstraint?.constant = 0
            self.animationWidthConstraint?.constant = self.view.frame.width
            self.animationHeightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height + 100
            //self.tabBarController?.tabBar.transform = .init(translationX: 0, y: 80)
            //self.tabBarController?.tabBar.isHidden = true
            
            guard let cell = self.animationFullScreenController?.tableView.cellForRow(at: [0,0]) as? FullScreenHeaderCell else { return }
            cell.todayCell.topConstraint?.constant = 48
            cell.layoutIfNeeded()   // to avoid the bouncing of the text label
        }, completion: nil)
    }
    
    func presentFullScreenAppController(indexPath: IndexPath) {
        let fullScreenController = TodayMultipleCellController(mode: .fullScreen)
        fullScreenController.appResults = todayItems[indexPath.item].appResults
        let nav = BackEnabledNavigationController(rootViewController: fullScreenController)
        nav.isNavigationBarHidden = true
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func handleCellCancel() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            guard let startFrame = self.animationStartFrame else { return }
            
            self.animationFullScreenController?.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            
            self.animationFullScreenController?.fullScreenHeaderCell.cancelButton.isHidden = true
            
            self.animationTopConstraint?.constant = startFrame.origin.y
            self.animationLeadingConstraint?.constant = startFrame.origin.x
            self.animationWidthConstraint?.constant = startFrame.width
            self.animationHeightConstraint?.constant = startFrame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.tabBarOriginY ?? self.view.frame.height - 50
            //self.tabBarController?.tabBar.transform = .identity
            //self.tabBarController?.tabBar.isHidden = false
            
            guard let cell = self.animationFullScreenController?.tableView.cellForRow(at: [0,0]) as? FullScreenHeaderCell else { return }
            cell.todayCell.topConstraint?.constant = 24
            cell.layoutIfNeeded()
        }, completion: { _ in
            self.animationFullScreenController?.view.removeFromSuperview()
            self.animationFullScreenController?.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
    @objc func handleTapApp(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayMultipleCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                presentFullScreenAppController(indexPath: indexPath)
                return
            }
            superView = superView?.superview
        }
    }
}
