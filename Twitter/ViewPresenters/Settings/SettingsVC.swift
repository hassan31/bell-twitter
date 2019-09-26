//
//  SettingsView.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, ModalSheetPresentable {

    // MARK: - IBOutlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblRadius: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    
    // MARK: - Properties
    var presenter = SettingsPresenter()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        maximizeToFullScreen()
        
        // Localised strings to be populated
        navigationItem.title = Strings.settingsTitle.localized
        btnSave.setTitle(Strings.btnSaveTitle.localized, for: .normal)
        lblHeader.text = Strings.settingsHeaderText.localized
        
        // Attach view controller to the presenter
        presenter.attachView(self)
        
        btnSave.setDefaultCornerRadius()
        
        // Get radius from UserDefaults & assign to the label and slider value
        let radius = Defaults.shared.getInt(SettingsConstants.radius)
        lblRadius.text = "\(radius) \(Strings.km.localized)"
        slider.value = Float(radius)
    }
}

// MARK: - IBAction Methods Methods
extension SettingsVC {
    
    @IBAction func actionDismiss(_ sender: UIButton) {
        dismissViewController()
    }
    
    @IBAction func actionSaveRadius(_ sender: UIButton) {
        dismissViewController()
    }
    
    @IBAction func actionValueChanged(_ sender: UISlider) {
        lblRadius.text = "\(Int(sender.value)) \(Strings.km.localized)"
    }
}

// MARK: - Helper Methods
extension SettingsVC {
    
    private func dismissViewController() {
        
        if let delegate = transitioningDelegate as? ModalSheetTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        
        dismiss(animated: true) {
            self.presenter.onSaveButtonClicked(Int(self.slider.value))
        }
    }
}
