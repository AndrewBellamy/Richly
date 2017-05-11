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

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var thisJournalDate = NSDate()
    var journal: Journal?
    var notificationCenter = NotificationCenter()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func upDate(_ sender: UIDatePicker) {
        notifyJournalTableOfDate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func addJournal(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jPNotificationKey), object: nil, userInfo: ["newDate" : thisJournalDate])
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
    
    func notifyJournalTableOfDate() {
        thisJournalDate = datePicker.date as NSDate
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jRNotificationKey), object: nil, userInfo: ["newDate" : thisJournalDate])
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


