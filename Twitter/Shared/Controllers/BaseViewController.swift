//
//  BaseViewController.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit


/** Delegate methods to be implemented in desired classes
 */
protocol BaseViewControllerDelegate {
    
    /** Settings button clicked to display settings view controller
     * - Parameters: sender: UIButton
    */
    func actionSettings(_ sender: UIButton)
    
    /** Refresh button clicked to fetch latest tweets
     * - Parameters: sender: UIButton
    */
    func actionReload(_ sender: UIButton)
    
    /** Toggle between map view and table view
     * - Parameters: sender: UIButton
    */
    func actionToggele(_ sender: UIButton)
    
    /** Search button of search bar is clicked
     * - Parameters: searchText: String
    */
    func searchBarSearchButtonPressed(_ searchText: String)
}

class BaseViewController: UIViewController {

    // MARK: - Proprties
    private var btnSettings: UIButton!
    private var btnRefresh: UIButton!
    private var btnToggleDisplay: UIButton!
    var searchBar: UISearchBar!
    
    var delegate: BaseViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        
        navigationController?.isNavigationBarHidden = self is SplashVC
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.helveticaMedium(16)]
        
        // Navigation buttons settings
        btnSettings = UIButton(type: .custom)
        btnSettings.setImage(UIImage(imageLiteralResourceName: "btn_settings"), for: .normal)
        btnSettings.addTarget(self, action: #selector(actionShowSettingsVC(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnSettings)
        
        btnRefresh = UIButton(type: .custom)
        btnRefresh.setImage(UIImage(imageLiteralResourceName: "btn_refresh"), for: .normal)
        btnRefresh.addTarget(self, action: #selector(actionRefresh(_:)), for: .touchUpInside)
        
        btnToggleDisplay = UIButton(type: .custom)
        let image = self is TweetsVC ? UIImage(imageLiteralResourceName: "btn_map") : UIImage(imageLiteralResourceName: "btn_list")
        btnToggleDisplay.setImage(image, for: .normal)
        btnToggleDisplay.addTarget(self, action: #selector(actionToggelTweetsView(_:)), for: .touchUpInside)
        
        // Combine both buttons in StackView and set as right navigation item
        let rightButtonsView = UIStackView(arrangedSubviews: [btnRefresh, btnToggleDisplay])
        rightButtonsView.axis = .horizontal
        rightButtonsView.distribution = .equalSpacing
        rightButtonsView.spacing = 10.0
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButtonsView)
        
        if !(self is SplashVC) {
            addSearchBar()
        }
    }
    
    /** Add search bar in base view controller
     */
    private func addSearchBar() {
        
        let frame = navigationController?.navigationBar.frame
        searchBar = UISearchBar(frame: CGRect.init(x: 0, y: (frame?.size.height ?? 44) + 45, width: Screen.width, height: 56))
        searchBar.placeholder = "Search #tags, trends, etc"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    // MARK: - UIButton Action Methods
    @objc func actionShowSettingsVC(_ sender: UIButton) {
        
        guard let delegate = self.delegate else {
            return
        }
        delegate.actionSettings(sender)
    }
    
    @objc func actionRefresh(_ sender: UIButton) {
        
        guard let delegate = self.delegate else {
            return
        }
        delegate.actionReload(sender)
    }
    
    @objc func actionToggelTweetsView(_ sender: UIButton) {
        
        guard let delegate = self.delegate else {
            return
        }
        delegate.actionToggele(sender)
    }
}

// MARK: - UISearchBar Delegate Methods
extension BaseViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let delegate = self.delegate else { return }
        guard let searchText = searchBar.text else { return }
        
        searchBar.text = nil
        searchBar.endEditing(true)
        
        delegate.searchBarSearchButtonPressed(searchText)
    }
}
