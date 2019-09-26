//
//  UIImageView++.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Set rounded view
    func setRoundCorner() {
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
    }
    
    /** Set radius corner of the view
     * - Parameters: radius: CGFloat
     */
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
