//
//  SettingsViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 30/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var journals: [Journal] = []

    @IBOutlet weak var journalCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateJournalCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetJournals(_ sender: Any) {
        deleteAllJournals()
        updateJournalCount()
    }
    
    // MARK: - Navigation
 
    @IBAction func cancelSettings(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - Core Data
    
    func updateJournalCount() {
        journals.removeAll()
        do {
            journals = try context.fetch(getJournals()) as! [Journal]
        } catch {
            print("fetch failed")
        }
        journalCount.text = String(journals.count) + " journals saved"
    }
    
    func getJournals() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
        
        return fetchrequest
    }
    
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
