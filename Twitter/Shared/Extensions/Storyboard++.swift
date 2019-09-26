//
//  Storyboard.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

// MARK: - UIStoryboard name's
enum Storyboard: String {
    case main = "Main"
    case launch = "Launch"
}

// MARK: - Storyboard Extension's
extension Storyboard {
    // MARK: - Properties
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    /// Get view controller based on your given storyboard
    func viewController<T: UIViewController>(
        viewControllerClass: T.Type,
        function: String = #function,
        line: Int = #line,
        file: String = #file
        ) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardId) as? T else {
            fatalError(
                "ViewController with identifier\(storyboardId), not found in \(self.rawValue) Storyboard."
                    + "\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)"
            )
        }
        return scene
    }

    /// Initialize your view controller
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
