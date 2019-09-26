//
//  SettingsPresenter.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

// MARK: - Settings Protocol Methods
protocol SettingsDelegate {
    func onRadiusChanged(radius: Int)
}

class SettingsPresenter {
    
    // MARK: - Properties
    var view: SettingsVC?
    var delegate: SettingsDelegate?
    
    /** This method is to be used to attach your view controller
    * Parameter view is your view controller that will be attached to this presenter
    */
    func attachView(_ view: SettingsVC) {
        self.view = view
    }
    
    
    func onSaveButtonClicked(_ radius: Int) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        Defaults.shared.setInt(radius, key: SettingsConstants.radius)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            delegate.onRadiusChanged(radius: radius)
        }
    }
}
