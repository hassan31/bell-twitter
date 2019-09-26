//
//  UIViewController.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardId: String {
        return "\(self)"
    }

    static func instantiate(fromStoryboard storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
    
    /** Show default alert with your desired title & message
     * - Parameters: title
     * - Parameters: message
    */
    func showAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    /// Get Loading Alert of UIAlertViewController
    func getLoadingAlert() -> UIAlertController {
        
        let alertController = UIAlertController(title: nil, message: Strings.loadingText.localized, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alertController.view.addSubview(loadingIndicator)
        
        return alertController
    }
    
    /** Show loading alert on your current view controller
     * - Parameters: loadingSpinner
    */
    func show(_ loadingSpinner: UIAlertController) {
        
        if !loadingSpinner.isBeingPresented {
            present(loadingSpinner, animated: true, completion: nil)
        }
    }
    
    // Hide loading alert
    func hide() {
        dismiss(animated: true, completion: nil)
    }
    
    /// Get the radius from User Defaults
    func getRadius() -> Int {
        return Defaults.shared.getInt(SettingsConstants.radius) == 0 ? 5 : Defaults.shared.getInt(SettingsConstants.radius)
    }
}
