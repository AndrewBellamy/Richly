//
//  JournalTableViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 28/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

var editJournal: Journal?

class JournalTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var journals: [Journal] = []

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(retrieveJournals),name: NSNotification.Name(rawValue: jRNotificationKey), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveJournals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editEntry") {
            let cell = (sender as AnyObject)
            let editCellRow = tableView.indexPath(for: cell as! UITableViewCell)?.row
            editJournal = journals[editCellRow!]
        }
    }
    
    // MARK: - Core Data
    
    func retrieveJournals() {
        do {
            let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
            
            let thisPredicate = NSPredicate(format: "date == %@", thisJournalDate as NSDate)
            
            fetchrequest.predicate = thisPredicate
            journals = try context.fetch(fetchrequest) as! [Journal]
        } catch {
            print("No journals retrieved")
        }
        tableview.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        cell.textLabel?.text = journals[indexPath.row].entry
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let condemedJournal = journals[indexPath.row]
            context.delete(condemedJournal)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            retrieveJournals()
        }
    }
}
