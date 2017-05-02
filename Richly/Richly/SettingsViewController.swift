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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelSettings(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func resetJournals(_ sender: Any) {
        deleteAllJournals()
        updateJournalCount()
    }
    
    func updateJournalCount() {
        journals.removeAll()
        do {
            journals = try context.fetch(getJournals()) as! [Journal]
            print(String(describing: journals[0].date))
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
    
    func resetAllParameters() {
        /*
         
         let journal = Parameter(context: context)
         journal.type = "People"
         journal.category = "Family"
         journal.name = "James"
         
         (UIApplication.shared.delegate as! AppDelegate).saveContext()
         */
        
        let person = Person(context: context)
        let place = Place(context: context)
        let activity = Activity(context: context)
        let weather = Weather(context: context)
        let time = Time(context: context)
        let impact = Impact(context: context)
        let feeling = Feeling(context: context)
        let consume = Consume(context: context)
        
        person.category = "Family"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        person.category = "Friends"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        place.category = "Home"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        place.category = "Outdoors"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        activity.category = "Past tense"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        activity.category = "Present tense"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        weather.category = "Temperature"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        weather.category = "Sky"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        time.category = "Interval"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        time.category = "Event"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        impact.category = "Problem"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        impact.category = "Solution"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        feeling.category = "Emotion"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        feeling.category = "Reaction"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        consume.category = "Visual"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        consume.category = "Audial"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
