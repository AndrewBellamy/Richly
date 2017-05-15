//
//  ViewController.swift
//  Richly - Proof of Concept
//
//  Created by Andrew Bellamy on 21/4/17.
//  Student ID: 215240036
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

var jRNotificationKey = "richly.journalRetrival.notificationKey"
var jDNotificationKey = "richly.journalDeletion.notificationKey"
var jGNotificationKey = "richly.journalGenerate.notificationKey"
var jPNotificationKey = "richly.jounralPassDate.notificationKey"

var thisJournalDate = Date()

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var notificationCenter = NotificationCenter()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setDate(thisJournalDate, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func upDate(_ sender: UIDatePicker) {
        createDate()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jRNotificationKey), object: nil)
    }
    
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
    
    
    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "settings", sender: nil)
    }
}


