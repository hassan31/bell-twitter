//
//  TweetsViewTests.swift
//  TwitterTests
//
//  Created by Muhammad Hassan on 2019-09-24.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import XCTest
@testable import Twitter

class TweetsViewTests: XCTestCase {

    var tweetsView: TweetsVC!
    var tableView: UITableView!
    
    override func setUp() {
        
        tweetsView = TweetsVC.instantiate(fromStoryboard: .main)
        _ = tweetsView.view
        tableView = tweetsView.tbl
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
    
    func testIfControllerHasTableView() {
        XCTAssertNotNil(tableView, "Controll should have the table view")
    }

    func testTableHasThreeNumberOfSections() {
        XCTAssertEqual(tableView?.numberOfSections, 1, "Tweets Table should have 1 sections")
    }

    func testNavigationTitle() {
        XCTAssertEqual("Most Recent Tweets", tweetsView.navigationItem.title)
    }
    
    func testFetchMostRecentTweets() {
        tweetsView.presenter.fetchMostRecentTweets("food", radius: 10)
    }
    
    func testIfTableViewHasTweetCell() {
        
        let cellIdentifier = TableCells.tweetCell
        let indexPath = IndexPath(row: 0, section: 0)
        guard tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) is (TweetCell) else {
            XCTAssertNil("Table View Should be able to deque cell with identifier: \(cellIdentifier)")
            return
        }
    }
    
    func testSettingsButtonClicked() {
        tweetsView.actionSettings(UIButton())
    }
    
    func testRefreshButtonClicked() {
        tweetsView.actionRefresh(UIButton())
    }
    
    func testToggleTweetsDisplayView() {
        tweetsView.actionToggele(UIButton())
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
    
    func testTweetsLoadingInTableView() {
        tweetsView.tbl.reloadData()
    }
    
    func testTweetCellWithData() {
        
        if let path = Bundle.main.path(forResource: "statuses", ofType: "json") {
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let tweetsResponse = try JSONDecoder().decode(TweetsResponse.self, from: data)
                
                let cellIdentifier = TableCells.tweetCell
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TweetCell
                cell?.configureCell(tweetsResponse.tweets[0])
                
            } catch {
                
                print(error)
                XCTAssert(false, "Parsing Failed. Tweets response is not as expected json")
            }
        }
    }
}
