//
//  HalfModalTransitionAnimator.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class ModalSheetTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Proprties
    var type: ModalSheetTransitionAnimatorType
    
    // MARK: - Initialization
    init(type: ModalSheetTransitionAnimatorType) {
        self.type = type
    }
    
    /** This method is used to create the animation for transitioning
     * - Parameters transitionContext: this is your view controller's context transition
     */
    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            
            from!.view.frame.origin.y = 800
            
            print("animating...")
            
        }) { (completed) -> Void in
            print("animate completed")
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    /** This method is used to return the transition duration
     * - Parameters transitionContext: this is your view controller's context transition
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
}

// MARK: - Transition Enum
internal enum ModalSheetTransitionAnimatorType {
    case Present
    case Dismiss
}
