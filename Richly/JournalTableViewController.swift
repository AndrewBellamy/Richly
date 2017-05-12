//
//  JournalTableViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 28/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class JournalTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var journals: [Journal] = []

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(retrieveJournals),name: NSNotification.Name(rawValue: jRNotificationKey), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveJournals() {
        do {
            let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
            
            let thisPredicate = NSPredicate(format: "date == %@", thisJournalDate)
            
            fetchrequest.predicate = thisPredicate
            journals = try context.fetch(fetchrequest) as! [Journal]
            if (journals.count != 0) {
                print(String(describing: journals[0].date))
            }
        } catch {
            print("No journals retrieved")
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journals.count
    }
    
}
