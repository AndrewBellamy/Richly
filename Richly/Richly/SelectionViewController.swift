//
//  SelectionViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 15/5/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class SelectionViewController: UIViewController {
    
    var notificationCenter = NotificationCenter()
    
    override func viewDidLoad() {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelAddEntry(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        if (editJournal != nil) {
            editJournal = nil
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: jDNotificationKey), object: nil)
        }
    }
    
    @IBAction func generateJournal(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: jGNotificationKey), object: nil)
    }

}

