//
//  UIViewController+AddChild.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import UIKit

/// Extension on UIViewController
extension UIViewController {
    
    /// Add child view controller to container view
    /// - Parameters:
    ///  - viewController: Child view controller
    ///  - containerView: Container view
    func add(asChildViewController viewController: UIViewController,
                    containerView: UIView) {
        
        addChild(viewController)
        
        containerView.addSubview(viewController.view)
        
        NSLayoutConstraint.activate([
                viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
        
//        viewController.view.frame = containerView.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth,
                                               // .flexibleHeight]
        viewController.didMove(toParent:
                                self)
    }
}
