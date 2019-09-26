//
//  HalfModalInteractiveTransition.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class ModalSheetInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Properties
    var viewController: UIViewController
    var presentingViewController: UIViewController?
    var panGestureRecognizer: UIPanGestureRecognizer
    
    var shouldComplete: Bool = false
    
    // MARK: - Initialization
    /** This method initializes your destination view controller to be presented
     * - Parameters view: source view controller's view
     * - Parameters presentingViewController: Destination view controller
     */
    init(viewController: UIViewController, withView view: UIView, presentingViewController: UIViewController?) {
        self.viewController = viewController
        self.presentingViewController = presentingViewController
        self.panGestureRecognizer = UIPanGestureRecognizer()
        
        super.init()
        
        self.panGestureRecognizer.addTarget(self, action: #selector(onPan))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        
        print("start interactive")
    }
    
    override var completionSpeed: CGFloat {
        get {
            return 1.0 - self.percentComplete
        }
        set {}
    }
    
    /** This method is used to add PAN gesture on your destination view controller to swip up or down
     */
    @objc func onPan(pan: UIPanGestureRecognizer) -> Void {
        let translation = pan.translation(in: pan.view?.superview)
        
        switch pan.state {
        case .began:
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
            break
            
        case .changed:
            let screenHeight = UIScreen.main.bounds.size.height - 50
            let dragAmount = screenHeight
            let threshold: Float = 0.2
            var percent: Float = Float(translation.y) / Float(dragAmount)

            percent = fmaxf(percent, 0.0)
            percent = fminf(percent, 1.0)
            
            update(CGFloat(percent))
            
            shouldComplete = percent > threshold
            
            break
            
        case .ended, .cancelled:
            if pan.state == .cancelled || !shouldComplete {
                cancel()
                
                print("cancel transition")
            }
            else {
                finish()
                
                print("finished transition")
            }
            
            break
            
        default:
            cancel()
            
            break
        }
    }
}
