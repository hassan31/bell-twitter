//
//  UIImageView++.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /** Load remote Image URL
     * - Parameters: url: URL
    */
    func loadImage(url: URL) {
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
