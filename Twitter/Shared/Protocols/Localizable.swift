//
//  Localizable.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

/** Localization Protocol that will be used to localise your strings in application
 */
protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    
    /** Stored Property to get localized string from your localized table
     */
    var localized: String {
        return NSLocalizedString(rawValue, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
    }
}
