//
//  TweetsMapViewTests.swift
//  
//
//  Created by Muhammad Hassan on 2019-09-24.
//

import XCTest
@testable import Twitter

class TweetsMapViewTests: XCTestCase {

    var tweetsMapView: TweetsMapVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tweetsMapView = TweetsMapVC.instantiate(fromStoryboard: .main)
        _ = tweetsMapView.view
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
        XCTAssertEqual("Most Recent Tweets", tweetsMapView.navigationItem.title)
    }
    
    func testFetchMostRecentTweets() {
        tweetsMapView.presenter.fetchMostRecentTweets("food", radius: 10)
    }
    
    func testSettingsButtonClicked() {
        tweetsMapView.actionSettings(UIButton())
    }
    
    func testRefreshButtonClicked() {
        tweetsMapView.actionRefresh(UIButton())
    }
    
    func testToggleTweetsDisplayView() {
        tweetsMapView.actionToggele(UIButton())
    }
    
    func testTweetsParsing() {
        
        if let path = Bundle.main.path(forResource: "statuses", ofType: "json") {
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let tweetsResponse = try JSONDecoder().decode(TweetsResponse.self, from: data)
                if tweetsResponse.tweets.count == 7 {
                    XCTAssert(true, "Tweets are parsed successfully")
                } else {
                    XCTAssert(false, "Parsing Failed. Tweets response is not as expected json")
                }
                
            } catch {
                
                print(error)
                XCTAssert(false, "Parsing Failed. Tweets response is not as expected json")
            }
        }
    }
}
