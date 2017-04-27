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

    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var journalTable: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    

    
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
        let file = "output.txt" //this is the file. we will write to and read from it
        
        let text = String(describing: setDate) //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                print(String(text2)!)
            }
            catch {/* error handling here */}
        }
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

}

