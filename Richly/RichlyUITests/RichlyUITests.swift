//
//  RichlyUITests.swift
//  RichlyUITests
//
//  Created by Andrew Bellamy on 21/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import XCTest

class RichlyUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainDatePicker() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let datePickersQuery = app.datePickers
        XCTAssert(datePickersQuery.pickerWheels.count == 3)
        
    }
    
    /*
     app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
     
     let toolbarsQuery = app.toolbars
     toolbarsQuery.buttons["Cancel"].tap()
     toolbarsQuery.buttons["Share"].tap()
     app.buttons["Cancel"].tap()
    */
}
