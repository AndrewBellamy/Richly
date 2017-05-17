//
//  RichlyTests.swift
//  RichlyTests
//
//  Created by Andrew Bellamy on 21/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import XCTest
import CoreData
@testable import Richly

class RichlyTests: XCTestCase {

    var richTextGenerator: RichTextGenerator!
    var journal: Journal!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        journal = Journal(context: context)
        richTextGenerator = RichTextGenerator(object: journal)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        context.delete(journal)
        journal = nil
        richTextGenerator = nil
        super.tearDown()
    }
    
    func testRandomReturner() {
        let array = ["one","two","three"]
        
        let result = richTextGenerator.randomReturner(array: array)
        
        XCTAssert(result == "one" || result == "two" || result == "three")
    }
    
    func testRichTextGenerator() {
        journal.person = nil
        journal.place = nil
        journal.activity = nil
        journal.weather = nil
        journal.time = nil
        journal.impact = nil
        journal.feeling = nil
        journal.consume = nil
        
        let result = richTextGenerator.generateText()
        
        
        XCTAssert(result == "Nothing much to write about today :)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
