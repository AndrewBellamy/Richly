//
//  ViewController.swift
//  Richly - Proof of Concept
//
//  Created by Andrew Bellamy : 215240036 on 21/4/17.
//  SIT206 Assignment 2
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

/**
 Global notification keys
 */
var jRNotificationKey = "richly.journalRetrival.notificationKey"
var jDNotificationKey = "richly.journalDeletion.notificationKey"
var jGNotificationKey = "richly.journalGenerate.notificationKey"
var jPNotificationKey = "richly.jounralPassDate.notificationKey"

/** Global variables */
var thisJournalDate = Date()

class ViewController: UIViewController {
    
    /**
     Initialization variables
    */
    var notificationCenter = NotificationCenter()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    /**
     In UI controls, set as variables for programmatic use.
    */
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setDate(thisJournalDate, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Calls the createDate method and posts a notification to the Journal Table View Controller.
    */
    @IBAction func upDate(_ sender: UIDatePicker) {
        createDate()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jRNotificationKey), object: nil)
    }
    
    /**
     Clears the time from the Date class and sets the global variable for predicate.
     Only for gregorian datetime as of May 2017.
    */
    func createDate() {
        let gregorian = Calendar(identifier: .gregorian)
        let now = datePicker.date
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        thisJournalDate = gregorian.date(from: components)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addEntry") {
            createDate()
        }
    }
    
    /**
     Handles the segue to the settings view.
    */
    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "settings", sender: nil)
    }
}


