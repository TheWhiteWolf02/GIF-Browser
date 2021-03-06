//
//  UINavigationControllerExtension.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import UIKit

extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
