//
//  BackEnabledNavigationController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/21.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1   //the number of controllers that has been pushed in to this nav
    }
}
