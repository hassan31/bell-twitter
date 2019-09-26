//
//  ViewController.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit
import TwitterKit
import CoreLocation

class TweetsVC: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet private weak var lblEmptyStatus: UILabel!
    
    // MARK: - Properties
    let presenter = TweetsPresenter()
    var arrTweets = [Tweet]()
    private var loadingSpinner: UIAlertController!
    var modalTransitioningDelegate: ModalSheetTransitioningDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        // Navigation Settings
        navigationItem.title = Strings.navigationTitle.localized
        
        // Register Table Cell
        tbl.registerCell(with: TableCells.tweetCell)
        presenter.attachView(view: self)
        
        self.delegate = self
        loadingSpinner = getLoadingAlert()
        
        // Location Settings
        LocationManager.sharedInstance.delegate = self
        LocationManager.sharedInstance.startUpdatingLocation()
        
//        Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { timer in
//            LocationManager.sharedInstance.startUpdatingLocation()
//        }
    }
}

// MARK: - BaseViewController Delegate Methods

extension TweetsVC: BaseViewControllerDelegate {
    
    func actionSettings(_ sender: UIButton) {
        
        let settingsVC = SettingsVC.instantiate(fromStoryboard: .main)
        settingsVC.presenter.delegate = self
        
        modalTransitioningDelegate = ModalSheetTransitioningDelegate(viewController: self, presentingViewController: settingsVC)
        settingsVC.modalPresentationStyle = .custom
        settingsVC.transitioningDelegate = modalTransitioningDelegate
        present(settingsVC, animated: true, completion: nil)
    }
    
    func actionToggele(_ sender: UIButton) {
        AppDelegate.app().window?.rootViewController = UINavigationController(rootViewController: TweetsMapVC.instantiate(fromStoryboard: .main))
    }
    
    func actionReload(_ sender: UIButton) {
        LocationManager.sharedInstance.startUpdatingLocation()
    }
    
    func searchBarSearchButtonPressed(_ searchText: String) {
        presenter.fetchTweetsWith(searchText)
    }
}

// MARK: - UITableView DataSource & Delegate Methods
extension TweetsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.tweetCell, for: indexPath) as? TweetCell else {
            return TweetCell()
        }
        
        cell.configureCell(arrTweets[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.fetchTweetDetails(arrTweets[indexPath.row].id )
    }
}

// MARK: - LocationManager Delegate Methods
extension TweetsVC: LocationManagerDelegate {
    
    func tracingLocation(currentLocation: CLLocation) {
        LocationManager.sharedInstance.stopUpdatingLocation()
        presenter.fetchMostRecentTweets(searchBar.text, radius: getRadius())
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        showAlert(Strings.errorTitle.localized, message: error.localizedDescription)
    }
}

// MARK: - Settings Delegate Methods
extension TweetsVC: SettingsDelegate {
    
    func onRadiusChanged(radius: Int) {
        presenter.fetchMostRecentTweets(searchBar.text, radius: radius)
    }
}

// MARK: - Helper Methods
extension TweetsVC {
    
    func showLoading() {
        show(loadingSpinner)
    }
    
    func hideLoading() {
        loadingSpinner.hide()
    }
    
    func setEmptyStatus() {
        
        tbl.isHidden = arrTweets.count == 0
        lblEmptyStatus.isHidden = arrTweets.count > 0
    }
    
    func reloadTweetsList(data: [Tweet]) {
        
        arrTweets = data
        setEmptyStatus()
        tbl.reloadData()
    }
    
    func showTweetDetailView(_ tweet: TWTRTweet) {
        
        let tweetDetailVC = TweetDetailVC.instantiate(fromStoryboard: .main)
        tweetDetailVC.tweet = tweet
        
        modalTransitioningDelegate = ModalSheetTransitioningDelegate(viewController: self, presentingViewController: tweetDetailVC)
        tweetDetailVC.modalPresentationStyle = .custom
        tweetDetailVC.transitioningDelegate = modalTransitioningDelegate
        present(tweetDetailVC, animated: true, completion: nil)
    }
}
