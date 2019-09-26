//
//  TweetsProtocol.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

/** Tweets Protocol
 * - Description: It can have the multiple methods based on your need and you can implement them where ever you want
 */
protocol TweetsProtocol {
    
    /** Fetch most recent tweets based on your location
    * Parameters: searchText: the keywords you will enter in search bar
    * Parameters: radius: It will the radius based on your location. You can set from Settings Screen
    */
    func fetchMostRecentTweets(_ searchText: String?, radius: Int)
    
    /** Fetch the details of your Tweet
    * Parameters: tweetId: tweetId will be used to fetch the details of your tweet.
    */
    func fetchTweetDetails(_ tweetId: Int)
    
    /** Fetch the tweets based on your search keyword
    * Parameters: keyword: you can enter the keyword, like #tags, any type of text to fetch the tweets
    */
    func fetchTweetsWith(_ keyword: String)
}
