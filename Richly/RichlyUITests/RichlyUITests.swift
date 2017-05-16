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
    
    func testJournalMainViewTable() {
        let app = XCUIApplication()
        //Main table exists
        XCTAssert(app.tables.count != 0)
    }
    
    func testAddButton() {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
        //Check that a table exists
        XCTAssert(app.tables.count != 0)
        //Check that we've navigated
        XCTAssert(app.toolbars.buttons["Selection"].exists)
        
    }
    
    func testAddandCancel() {
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
        
        let toolbarsQuery = app.toolbars
        toolbarsQuery.buttons["Cancel"].tap()
        XCTAssert(toolbarsQuery.buttons["Richly"].exists)
        
    }
    
    func testAddingParamter() {
        let app = XCUIApplication()
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
        app.tables.children(matching: .cell).element(boundBy: 0).children(matching: .button).element.tap()
        window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element.tap()
        window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element.typeText("Dan")
        app.typeText("\r")
        app.toolbars.buttons["Done"].tap()
    }
    
    /*
     app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .button).element.tap()
     
     let toolbarsQuery = app.toolbars
     toolbarsQuery.buttons["Cancel"].tap()
     toolbarsQuery.buttons["Share"].tap()
     app.buttons["Cancel"].tap()
    */
}
