//
//  SelectionViewController.swift
//  Richly
//
//  Created by Andrew Bellamy : 215240036 on 15/5/17.
//  SIT206 Assignment 2
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class SelectionViewController: UIViewController {
    /**
     Initialization variables
    */
    var notificationCenter = NotificationCenter()
    
    override func viewDidLoad() {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Cancels the workflow for creating/editing a journal.
     Clears the journal stored in global variable, or posts a
     notification to delete the new journal from the context.
    */
    @IBAction func cancelAddEntry(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        if (editJournal != nil) {
            editJournal = nil
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: jDNotificationKey), object: nil)
        }
    }
    
    /**
     Posts a notification to the parameter view controller to perfrom the segue,
     this is to ensure the journal is passed between the view controllers.
    */
    @IBAction func generateJournal(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jGNotificationKey), object: nil)
    }

}

