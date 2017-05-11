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
        let people : [Person] = Array(self.journal.person!) as! [Person]
        let places : [Place] = Array(self.journal.place!) as! [Place]
        let time : [Time] = Array(self.journal.time!) as! [Time]
        let activities : [Activity] = Array(self.journal.activity!) as! [Activity]
        let weather : [Weather] = Array(self.journal.weather!) as! [Weather]
        let impacts : [Impact] = Array(self.journal.impact!) as! [Impact]
        let feelings : [Feeling] = Array(self.journal.feeling!) as! [Feeling]
        let experiences : [Consume] = Array(self.journal.consume!) as! [Consume]
        
        var upperPronoun = "I"
        var lowerPronoun = "I"
        var single: Bool = true
        var journalContainsMaterial: Bool = false
        var intro: String = randomReturner(array: ["Today","This day"])
        
        if (people.count != 0) {
            upperPronoun = "We"
            lowerPronoun = "we"
            single = false
            journalContainsMaterial = true
        }
        // MARK: - Handles the inclusion of time
        
        if (time.count != 0) {
            journalContainsMaterial = true
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
            intro += ", I spent the day"
        }
        
        // MARK: - Handles the inclusion of people in entry
        
        if (single == false) {
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
        
        var midsection = " "
        
        // MARK: - Handles the inclusion of places
        
        if (places.count != 0) {
            journalContainsMaterial = true
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
        
        if (activities.count != 0) {
            journalContainsMaterial = true
            var count = 0
            for activity in activities {
                let length = activities.count
                if (count == 0) {
                    if (activity.category == "Past Tense") {
                        midsection += upperPronoun + " " + randomReturner(array: ["went ","decided to go "]) + activity.name!
                    }
                    if (activity.category == "Present Tense") {
                        midsection += upperPronoun + " " + activity.name!
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
            midsection += "."
        } else {
            midsection += upperPronoun + " didn't really need to do much."
        }
        
        // MARK: - Handles the inclusion of weather
        
        if (weather.count != 0) {
            journalContainsMaterial = true
            var count = 0
            for isLike in weather {
                if (count == 0) {
                    if (isLike.category == "Sky") {
                        midsection += "The sky was " + isLike.name!
                    }
                    if (isLike.category == "Temperature") {
                        midsection += "The temperature felt " + isLike.name!
                    }
                }
                if (count > 0) {
                    if (isLike.category == "Sky") {
                        midsection += ", and the sky was " + isLike.name!
                    }
                    if (isLike.category == "Temperature") {
                        midsection += ", and the temperature felt " + isLike.name!
                    }
                }
                count += 1
            }
            midsection += "."
        }
        
        newText += midsection
        
        var tailSection = " "
        
        // MARK: - Handles the inclusion of experiences
        
        if (experiences.count != 0) {
            journalContainsMaterial = true
            var count = 0
            for experience in experiences {
                if (count == 0) {
                    if (experience.category == "Food") {
                        tailSection += upperPronoun + randomReturner(array: [" ate "," ended up eating "]) + experience.name!
                    }
                    if (experience.category == "Information") {
                        tailSection += upperPronoun + randomReturner(array: [" found out about "," learned about "]) + experience.name!
                    }
                    if (experience.category == "Visual") {
                        tailSection += upperPronoun + randomReturner(array: [" saw "," watched "]) + experience.name!
                    }
                    if (experience.category == "Audial") {
                        tailSection += upperPronoun + randomReturner(array: [" heard "," listenend to "]) + experience.name!
                    }
                }
                if (count > 0) {
                    if (experience.category == "Food") {
                        tailSection += randomReturner(array: [", then " + lowerPronoun + " also ate some ",", before " + lowerPronoun + " had some "]) + experience.name!
                    }
                    if (experience.category == "Information") {
                        tailSection += randomReturner(array: [", " + lowerPronoun +  " also found out about ",", then" + lowerPronoun + " learned about "]) + experience.name!
                    }
                    if (experience.category == "Visual") {
                        tailSection += randomReturner(array: [", " + lowerPronoun + " also saw ",", then " + lowerPronoun + " watched "]) + experience.name!
                    }
                    if (experience.category == "Audial") {
                        tailSection += randomReturner(array: [", then " + lowerPronoun + " heard ",", and " + lowerPronoun + " listenend to "]) + experience.name!
                    }
                }
                count += 1
            }
            tailSection += "."
        }
        
        // MARK: - Handles the inclusion of impacts
        
        if(impacts.count != 0) {
            journalContainsMaterial = true
            var count = 0
            for impact in impacts {
                if (count == 0) {
                    if (impact.category == "Problem") {
                        tailSection += randomReturner(array: [" There was a problem with "," " + upperPronoun + " had a problem with "]) + impact.name!
                    }
                    if (impact.category == "Solution") {
                        tailSection += randomReturner(array: [" There was an easy fix with "," " + upperPronoun + " avoided a major issue when "]) + impact.name!
                    }
                }
                if (count > 0) {
                    if (impact.category == "Problem") {
                        tailSection += randomReturner(array: [". Unfortunately there was an issue with ",". " + upperPronoun + " ended up having a problem with "]) + impact.name!
                    }
                    if (impact.category == "Solution") {
                        tailSection += randomReturner(array: [". Luckily the solutio was ",". " + upperPronoun + " knew it was all sorted with "]) + impact.name!
                    }
                }
                count += 1
            }
            tailSection += "."
        }
        
        newText += tailSection
        // MARK: - Handles the inclusion of feelings
        
        var feelSection = " "
        
        if(feelings.count != 0) {
            journalContainsMaterial = true
            for feeling in feelings {
                if (feeling.category == "Emotion") {
                    feelSection += "*" + upperPronoun + " felt " + feeling.name! + " about ..."
                }
                if (feeling.category == "Reaction") {
                    feelSection += "My reation to ... was " + feeling.name! + "."
                }
            }
        }
        
        newText += feelSection
        
        
        if (journalContainsMaterial) {
            thisText = newText
        }
        return thisText
    }

    
}
