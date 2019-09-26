//
//  TweetsPresenter.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-22.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class TweetsPresenter {
    
    var view: TweetsVC?
    
    func attachView(view: TweetsVC) {
        self.view = view
    }
}

extension TweetsPresenter: TweetsProtocol {
    
    func fetchMostRecentTweets(_ searchText: String?, radius: Int) {
        
        view?.showLoading()

        APIManager.shared.searchWithRadius(radius, keyword: searchText ?? "ios") { (result: TweetsResponse?) -> (Void) in
            
            self.view?.hideLoading()
            if let tweets = result?.tweets, !tweets.isEmpty {
                self.view?.reloadTweetsList(data: tweets)
            } else {
                self.view?.setEmptyStatus()
            }
        }
    }
    
    func fetchTweetsWith(_ keyword: String) {
        
        view?.showLoading()
        
        APIManager.shared.searchTweetsWith(keyword) { (result: TweetsResponse?) -> (Void) in
            
            self.view?.hideLoading()
            if let tweets = result?.tweets, !tweets.isEmpty {
                self.view?.reloadTweetsList(data: tweets)
            } else {
                self.view?.setEmptyStatus()
            }
        }
    }
    
    func fetchTweetDetails(_ tweetId: Int) {
        
        view?.showLoading()

        APIManager.shared.fetchTweetDetail(tweetId: tweetId) { (tweet, error) -> (Void) in

            self.view?.hideLoading()
            guard tweet != nil else {
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.view?.showTweetDetailView(tweet!)
            }
        }
    }
}
