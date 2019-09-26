//
//  Configurecell.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

protocol ConfigureCell {
    
    /** Associated Type: You can pass your desired custom object while configuring the cell
     */
    associatedtype T
    
    /** Method to configure your data in table cells
     * - Parameters data: This is your custom object based on your fetch results
     */
    func configureCell(_ data: T)
}
