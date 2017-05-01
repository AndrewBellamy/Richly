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
    
    @IBAction func addEntry(_ sender: UIButton) {
        performSegue(withIdentifier: "addEntry", sender: nil)
        journal = Journal(context: context)
        journal?.date = thisJournalDate
    }
    
    @IBAction func cancelEntry(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "cancelEntry", sender: nil)
        journal = nil
    }

    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "settings", sender: nil)
    }
    
    @IBAction func addParameter(_ sender: Any) {
        /*
        
        let journal = Parameter(context: context)
        journal.type = "People"
        journal.category = "Family"
        journal.name = "James"
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        */
        //deleteAllParamters()
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


