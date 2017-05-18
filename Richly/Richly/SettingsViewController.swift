//
//  SettingsViewController.swift
//  Richly
//
//  Created by Andrew Bellamy : 215240036 on 30/4/17.
//  SIT206 Assignment 2
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    /**
     Initialization variables
    */
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var journals: [Journal] = []

    /**
     In UI controls, set as variables for programmatic use.
    */
    @IBOutlet weak var journalCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateJournalCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Calls the deleteAllJournals and updateJournalCount methods
     - parameters:
        - sender: Any
    */
    @IBAction func resetJournals(_ sender: Any) {
        deleteAllJournals()
        updateJournalCount()
    }
    
    // MARK: - Navigation
    
    /**
     Dismisses the presenting view controller
    */
    @IBAction func cancelSettings(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - Core Data
    
    /**
     Sets the count of all journals, by retrieving NSManagedObjects from context
    */
    func updateJournalCount() {
        journals.removeAll()
        do {
            journals = try context.fetch(getJournals()) as! [Journal]
        } catch {
            print("fetch failed")
        }
        journalCount.text = String(journals.count) + " journals saved"
    }
    
    /**
     Convenience method for creating a fetch request for Journal entity.
     - returns:
        NSFetchRequest as fetchrequest
    */
    func getJournals() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
        
        return fetchrequest
    }
    
    /**
     Batch deletes all Journal NSManagedObjects from the context
    */
    func deleteAllJournals() {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchrequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("couldn't delete everything")
        }
        
    }
    
}
