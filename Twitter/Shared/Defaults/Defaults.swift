//
//  Defaults.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-24.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class Defaults {
    
    static let shared = Defaults()
    
    /** Set integer to UserDefaults
     * - Parameters value
     * - Parameters key
    */
    func setInt(_ value: Int, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /** Get integer from UserDefaults
     * - Parameters key
     */
    func getInt(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key) 
    }
}
