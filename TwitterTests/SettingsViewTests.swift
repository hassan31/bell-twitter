//
//  SettingsViewTests.swift
//  TwitterTests
//
//  Created by Muhammad Hassan on 2019-09-24.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import XCTest
@testable import Twitter

class SettingsViewTests: XCTestCase {

    var settingsView: SettingsVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        settingsView = SettingsVC.instantiate(fromStoryboard: .main)
        _ = settingsView.view
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
        XCTAssertEqual("Settings", settingsView.lblTitle.text)
    }

    func testSaveButtonTitle() {
        XCTAssertEqual("Save", settingsView.btnSave.titleLabel?.text)
    }
    
    func testOnSaveButtonClicked() {
        settingsView.presenter.onSaveButtonClicked(10)
    }
}
