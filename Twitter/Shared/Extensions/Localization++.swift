//
//  Localization++.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

/// Defined the localization variables to be used in your views
enum Strings: String, Localizable {
    
    case navigationTitle = "navigationTitle"
    case settingsTitle = "settingsTitle"
    case tweetDetailsTitle = "tweetDetailsTitle"
    case loadingText = "loadingText"
    case errorTitle = "errorTitle"
    case successTitle = "successTitle"
    case retweetSuccessMessage = "retweetSuccessMessage"
    case favoriteSuccessMessage = "favoriteSuccessMessage"
    case okText = "okText"
    case loginErrorMessage = "loginError"
    case btnSaveTitle = "btnSaveTitle"
    case settingsHeaderText = "settingsHeaderText"
    case km = "km"
    
    var tableName: String {
        return "Localization"
    }
}
