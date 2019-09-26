//
//  UITableView++.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

extension UITableView {
    
    /** Register your cell nib file
     * - Parameters: name: Name of the Nib
    */
    func registerCell(with name: String) {
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    /** Register your cell class file
     * - Parameters: name: Name of the Class
    */
    func registerClass(with name: String) {
        register(NSClassFromString(name).self, forCellReuseIdentifier: name)
    }
}
