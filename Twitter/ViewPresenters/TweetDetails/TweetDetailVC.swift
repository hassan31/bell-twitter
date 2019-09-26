//
//  TweetDetailView.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit
import TwitterKit

class TweetDetailVC: UIViewController, ModalSheetPresentable {

    // MARK: - IBOutlets
    @IBOutlet weak var tweetContainerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnReTweet: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    
    // MARK: - Proprties
    var tweet: TWTRTweet?
    private var loadingSpinner: UIAlertController!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        maximizeToFullScreen()
        lblTitle.text = Strings.tweetDetailsTitle.localized
        btnFavorite.setRoundCorner()
        btnReTweet.setRoundCorner()
        
        loadingSpinner = getLoadingAlert()
        
        let twitterView = TWTRTweetView(tweet: tweet, style: TWTRTweetViewStyle.compact)
        twitterView.backgroundColor = .clear
        twitterView.frame = CGRect.init(x: 0, y: 0, width: Screen.width, height: tweetContainerView.frame.size.height)
        tweetContainerView.addSubview(twitterView)
    }
}

// MARK: - IBAction Methods
extension TweetDetailVC {
    
    @IBAction func actionDismiss(_ sender: UIButton) {
//        sheetViewController?.closeSheet()
        
        if let delegate = transitioningDelegate as? ModalSheetTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionMakeFavorite(_ sender: UIButton) {
        
        show(loadingSpinner)
        APIManager.shared.favoriteTweet(forID: tweet?.tweetID ?? "1234") { (success) in
            
            self.loadingSpinner.hide()
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert(Strings.successTitle.localized, message: Strings.favoriteSuccessMessage.localized)
                }
            }
        }
    }
    
    @IBAction func actionReTweet(_ sender: UIButton) {
        
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            retweet()
        } else {
            
            TWTRTwitter.sharedInstance().logIn { session, error in

                if session != nil {
                    self.retweet()
                } else {
                    self.showAlert(Strings.errorTitle.localized, message: Strings.loginErrorMessage.localized)
                }
            }
        }
    }
}

// MARK: - Helper Methods
extension TweetDetailVC {
    
    private func retweet() {
        
        guard let tweetId = tweet?.tweetID else { return }
        
        show(loadingSpinner)
        APIManager.shared.retweet(forTweetRequestId: "1234", tweetId: tweetId) { (success) in
            
            self.loadingSpinner.hide()
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert(Strings.successTitle.localized, message: Strings.retweetSuccessMessage.localized)
                }
            }
        }
    }
}
