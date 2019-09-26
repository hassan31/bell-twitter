//
//  UIFont++.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

extension UIFont {
    
    /** Get helveticaRegular font
     * - Parameters: size: CGFloat
     */
    class func helveticaRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica Neue", size: size)!
    }
    
    /** Get helveticaBold font
    * - Parameters: size: CGFloat
    */
    class func helveticaBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
    
    /** Get helveticaMedium font
    * - Parameters: size: CGFloat
    */
    class func helveticaMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
}
