//
//  ViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 21/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
//import JBDatePicker

class ViewController: UIViewController, JBDatePickerViewDelegate {

    
    @IBOutlet weak var datePicker: JBDatePickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - JBDatePickerViewDelegate implementation
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(String(describing: dayView.date))")
    }
}

