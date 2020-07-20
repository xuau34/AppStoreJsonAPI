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
    
    var animationStartFrame: CGRect?
    var animationFullScreenController: FullScreenController?
    var tabBarOriginY: CGFloat?
    var animationTopConstraint: NSLayoutConstraint?
    var animationLeadingConstraint: NSLayoutConstraint?
    var animationWidthConstraint: NSLayoutConstraint?
    var animationHeightConstraint: NSLayoutConstraint?
    
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
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenController = FullScreenController()
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
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimationCancel)))
        
        //using view.frame to animate is not entirely reliable, so the better way is with auto layout constraints
        view.translatesAutoresizingMaskIntoConstraints = false
        animationTopConstraint = view.topAnchor.constraint(equalTo: self.view.topAnchor ,constant: startFrame.origin.y)
        animationLeadingConstraint = view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor ,constant: startFrame.origin.x)
        animationWidthConstraint = view.widthAnchor.constraint(equalToConstant: startFrame.width)
        animationHeightConstraint = view.heightAnchor.constraint(equalToConstant: startFrame.height)
        [animationTopConstraint, animationLeadingConstraint, animationWidthConstraint, animationHeightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()   //to force it to execute the layout
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.animationTopConstraint?.constant = 0
            self.animationLeadingConstraint?.constant = 0
            self.animationWidthConstraint?.constant = self.view.frame.width
            self.animationHeightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height + 100
            //self.tabBarController?.tabBar.transform = .init(translationX: 0, y: 80)
            //self.tabBarController?.tabBar.isHidden = true
        }, completion: nil)
    }
    
    @objc func handleAnimationCancel(gesture: UIGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            guard let startFrame = self.animationStartFrame else { return }
            
            self.animationFullScreenController?.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            
            self.animationTopConstraint?.constant = startFrame.origin.y
            self.animationLeadingConstraint?.constant = startFrame.origin.x
            self.animationWidthConstraint?.constant = startFrame.width
            self.animationHeightConstraint?.constant = startFrame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.tabBarOriginY ?? self.view.frame.height - 50
            //self.tabBarController?.tabBar.transform = .identity
            //self.tabBarController?.tabBar.isHidden = false
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
            self.animationFullScreenController?.removeFromParent()
        })
    }
}
