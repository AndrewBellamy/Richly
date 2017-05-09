//
//  RichTextGenerator.swift
//  Richly
//
//  Created by Andrew Bellamy on 6/5/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RichTextGenerator {
    var journal : Journal
    
    init(object: Journal) {
        self.journal = object
    }
    
    // Returns a randomly selected string from the array, passed in
    func randomReturner(array: [String]) -> String {
        let randomizer = Int(arc4random_uniform(UInt32(array.count)))
        return array[randomizer]
    }
    
    func generateText() -> String {
        
        var thisText = "Nothing much to write about today :)"
        var newText = ""
        var tempStr = ""
        var people : [Person] = []
        var places : [Place] = []
        var time : [Time] = []
        var activities : [Activity] = []
        var weather : [Weather] = []
        var impacts : [Impact] = []
        var feelings : [Feeling] = []
        var experiences : [Consume] = []
        
        var upperPronoun = "I"
        var lowerPronoun = "I"
        var single: Bool = true
        var journalContainsMaterial: Bool = false
        var intro: String = randomReturner(array: ["Today","This day"])
        
        if (journal.person != nil) {
            upperPronoun = "We"
            lowerPronoun = "we"
            single = false
            journalContainsMaterial = true
        }
        // MARK: - Handles the inclusion of time
        
        if (journal.time != nil) {
            journalContainsMaterial = true
            let timeRelationship = journal.time
            time = Array(timeRelationship!) as! [Time]
            var count = 0
            for period in time {
                if (count == 0) {
                    if (period.category == "Event") {
                        if (period.name?.lowercased().contains("birthday"))! {
                            intro += " was SOMEONE's " + period.name!
                        } else {
                            intro += " was the day of " + period.name!
                        }
                    }
                    if (period.category == "Interval") {
                        intro += " I spent the " + period.name!
                    }
                }
                if (count == 1 && period.category == "Event") {
                    intro += " of " + period.name!
                }
                if (count > 1 && period.category == "Interval") {
                    intro += " then I spent the " + period.name!
                }
                if (count > 1 && period.category == "Event") {
                    intro += " for " + period.name!
                }
                count += 1
            }
        } else {
            intro += " I spent the day"
        }
        
        // MARK: - Handles the inclusion of people in entry
        
        if (single == false) {
            let personRelationship = journal.person
            people = Array(personRelationship!) as! [Person]

            intro += " with "
            var count = 0
            for person in people {
                if (count == 0) {
                    intro += "my " + person.category!.lowercased() + " " + person.name!
                    
                }
                if (count > 0){
                    intro += ", and my " + person.category!.lowercased() + " " + person.name!
                }
                count += 1
            }
            intro += "."
        } else {
            intro += " by myself."
        }
        
        newText = intro
        
        var midsection = ""
        
        // MARK: - Handles the inclusion of places
        
        if (journal.place != nil) {
            journalContainsMaterial = true
            let placeRelationship = journal.place
            places = Array(placeRelationship!) as! [Place]
            
            midsection += upperPronoun
            var count = 0
            for place in places {
                let length = places.count
                if (count == 0) {
                    if (place.category == "Home") {
                        midsection += " stayed at " + place.name!
                    }
                    if (place.category == "Outdoors") {
                        midsection += " went out to " + place.name!
                    }
                    
                }
                if (count > 0 && count < length) {
                    if (place.category == "Home") {
                        midsection += ", " + place.name!
                    }
                    if (place.category == "Outdoors") {
                        midsection += ", then" + lowerPronoun + " went out to " + place.name!
                    }
                }
                if (count == length) {
                    if (place.category == "Home") {
                        midsection += " and finally " + place.name!
                    }
                    if (place.category == "Outdoors") {
                        midsection += ", before ending up at " + place.name!
                    }
                }
                count += 1
            }
            
            midsection += "."
        }
        
        // MARK: - Handles the inclusion of activities
        
        if (journal.activity != nil) {
            journalContainsMaterial = true
            let activityRelationship = journal.activity
            activities = Array(activityRelationship!) as! [Activity]
            var count = 0
            for activity in activities {
                let length = activities.count
                if (count == 0) {
                    if (activity.category == "Past Tense") {
                        midsection += upperPronoun + " " + activity.name!
                    }
                    if (activity.category == "Present Tense") {
                        midsection += upperPronoun + " " + randomReturner(array: ["went ","decided to go "]) + activity.name!
                    }
                }
                if (count > 0 && count < length) {
                    if (activity.category == "Past Tense") {
                        midsection += randomReturner(array: [", before going ",", and then " + lowerPronoun + " "]) + activity.name!
                    }
                    if (activity.category == "Present Tense") {
                        midsection +=  randomReturner(array: [" and " + lowerPronoun + " also went ",", then " + lowerPronoun + " went ",", before" + lowerPronoun + " decided to go "]) + activity.name!
                    }
                }
                if (count == length) {
                    if (activity.category == "Past Tense") {
                        midsection += randomReturner(array: [", before " + lowerPronoun + " finally decided to ",", and lastly " + lowerPronoun + " "]) + activity.name!
                    }
                    if (activity.category == "Present Tense") {
                        midsection +=  randomReturner(array: [" and " + lowerPronoun + " finally went ",", then " + lowerPronoun + " finished with a spot of ",", before" + lowerPronoun + " decided to go "]) + activity.name!
                    }
                }
                count += 1
            }
        } else {
            midsection += upperPronoun + " didn't really need to do much."
        }
        
        
        
        
        if (journalContainsMaterial) {
            thisText = newText
        }
        return thisText
    }

    
}
