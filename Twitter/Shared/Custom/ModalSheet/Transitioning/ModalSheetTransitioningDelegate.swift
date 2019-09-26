//
//  HalfModalTransitioningDelegate.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class ModalSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Proerties
    var viewController: UIViewController
    var presentingViewController: UIViewController
    var interactionController: ModalSheetInteractiveTransition
    
    var interactiveDismiss = true
    
    /** Initialization of you view controller
     * - Parameters viewController: Source ViewController
     * - Parameters presentingViewController: Destination ViewController
     */
    init(viewController: UIViewController, presentingViewController: UIViewController) {
        self.viewController = viewController
        self.presentingViewController = presentingViewController
        self.interactionController = ModalSheetInteractiveTransition(viewController: self.viewController, withView: self.presentingViewController.view, presentingViewController: self.presentingViewController)
        
        super.init()
    }
    
    /** This method is used to dismiss your view controller with animation
     * - Parameters dismissed: View Controller to be dismissed
     */
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalSheetTransitionAnimator(type: .Dismiss)
    }
    
    /** This method is used to present your view controller with animation
     * - Parameters presenting: Destination View Controller
     * - Parameters source: View Controller from where to be presented
     */
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    /** This method is used to dismiss your view controller with swiping down */
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if interactiveDismiss {
            return self.interactionController
        }
        
        return nil
    }
    
}
