//
//  TweetsMapPresenter.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class TweetsMapPresenter {
    
    var view: TweetsMapVC?
    
    func attachView(_ view: TweetsMapVC) {
        self.view = view
    }
}

extension TweetsMapPresenter: TweetsProtocol {
    
    // Empty implementation
    func fetchTweetsWith(_ keyword: String) {
    }
    
    func fetchMostRecentTweets(_ searchText: String?, radius: Int) {
        
        view?.showLoading()

        APIManager.shared.searchWithRadius(radius, keyword: searchText ?? "ios") { (result: TweetsResponse?) -> (Void) in

            self.view?.hideLoading()
            
            if let tweets = result?.tweets, !tweets.isEmpty {
                self.view?.reloadTweetsOnMap(data: tweets)
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
