//
//  ViewController.swift
//  Richly - Proof of Concept
//
//  Created by Andrew Bellamy on 21/4/17.
//  Student ID: 215240036
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var params: [Parameter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //topLabel.text = "Richly"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func upDate(_ sender: UIDatePicker) {
        let setDate = datePicker.date
        print(String(describing: setDate))
        //TODO: use this to retrieve the data assigned to each date.
    }
    
    @IBAction func addEntry(_ sender: UIButton) {
        performSegue(withIdentifier: "addEntry", sender: nil)
    }
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //Place any other segue preps in here by identifier.
     if segue.identifier == "SymbolSelectSegue" {
     segue.
     }
     }
     */
    
    @IBAction func cancelEntry(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "cancelEntry", sender: nil)
    }

    @IBAction func addParameter(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let journal = Parameter(context: context)
        journal.type = "People"
        journal.category = "Family"
        journal.name = "James"
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            params = try context.fetch(Parameter.fetchRequest())
        } catch {
            print("fetch failed")
        }
        
        for item in params {
            print("" + item.name!)
        }
    }

    
}


