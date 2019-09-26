//
//  SplashVC.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit
import TwitterKit
import QuartzCore

class SplashVC: BaseViewController, CAAnimationDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivLogo: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.ivLogo.transform = CGAffineTransform.identity.scaledBy(x: 50, y: 50)
        }) { (finished) in
            let navC = UINavigationController.init(rootViewController: TweetsVC.instantiate(fromStoryboard: .main))
            AppDelegate.app().window?.rootViewController = navC
        }
    }
}
