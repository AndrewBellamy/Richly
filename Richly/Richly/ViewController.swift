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
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        
        // Change the time to 9:30:00 in your locale
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        thisJournalDate = gregorian.date(from: components)!
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
        
        // Change the time to 9:30:00 in your locale
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        thisJournalDate = gregorian.date(from: components)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func addJournal(_ sender: Any) {
        /*
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jPNotificationKey), object: nil, userInfo: ["newDate" : thisJournalDate])
        */
    }

    @IBAction func cancelAddEntry(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jDNotificationKey), object: nil)
    }
    
    @IBAction func generateJournal(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jGNotificationKey), object: nil)
    }
    
    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "settings", sender: nil)
    }

    func deleteAllParamters() {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Parameter")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchrequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("couldn't delete everything")
        }
        
    }
}


