//
//  RichlyTests.swift
//  RichlyTests
//
//  Created by Andrew Bellamy on 21/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import XCTest
@testable import Richly

class RichlyTests: XCTestCase {

    var mainViewController: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mainViewController = ViewController()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
}
