//
//  TweetDetailTests.swift
//  TwitterTests
//
//  Created by Muhammad Hassan on 2019-09-24.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import XCTest
@testable import Twitter

class TweetDetailTests: XCTestCase {

    var tweetDetailView: TweetDetailVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tweetDetailView = TweetDetailVC.instantiate(fromStoryboard: .main)
        _ = tweetDetailView.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testNavigationTitle() {
        XCTAssertEqual("Tweet Details", tweetDetailView.lblTitle.text)
    }
    
    func testRetweet() {
        
        APIManager.shared.retweet(forTweetRequestId: "1234", tweetId: "968013469743288300") { (success) in
            if success {
                XCTAssert(true, "You have successfully retweeted.")
            } else {
                XCTAssert(false, "Something wrong while retweeting.")
            }
        }
    }
    
//    func testFavoriteTweet() {
//        
//        APIManager.shared.favoriteTweet(forID: "968013469743288300") { (success) in
//            
//            if success {
//                XCTAssert(true, "You have successfully retweeted.")
//            } else {
//                XCTAssert(false, "Something wrong while retweeting.")
//            }
//        }
//    }
}
