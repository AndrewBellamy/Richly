//
//  AddViewController.swift
//  Richly
//
//  Created by Andrew Bellamy : 215240036 on 2/5/17.
//  SIT206 Assignment 2
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    /**
     Initialization variables
    */
    var parameterToAdd = Int()
    var objectForJournal = parameterObject()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let CategoryFarm = categoryFarm()
    var currentCategory: [String] = []

    /**
     In UI controls, set as variables for programmatic use.
    */
    @IBOutlet weak var topLabel: UIBarButtonItem!
    @IBOutlet weak var categorySelected: UILabel!
    @IBOutlet weak var nameEntered: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch parameterToAdd {
        case 0:
            topLabel.title = "Add Person"
            currentCategory = CategoryFarm.personCategory
        case 1:
            topLabel.title = "Add Place"
            currentCategory = CategoryFarm.placeCategory
        case 2:
            topLabel.title = "Add Activity"
            currentCategory = CategoryFarm.activityCategory
        case 3:
            topLabel.title = "Add Weather"
            currentCategory = CategoryFarm.weatherCategory
        case 4:
            topLabel.title = "Add Time"
            currentCategory = CategoryFarm.timeCategory
        case 5:
            topLabel.title = "Add Impact"
            currentCategory = CategoryFarm.impactCategory
        case 6:
            topLabel.title = "Add Feeling"
            currentCategory = CategoryFarm.feelingCategory
        case 7:
            topLabel.title = "Add Experience"
            currentCategory = CategoryFarm.consumeCategory
        default:
            cancelAdd((Any).self)
        }
        categorySelected.text = currentCategory[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentCategory[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categorySelected.text = currentCategory[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameEntered {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    /**
     Sets the done button to enabled when text exists in the name input field
     - parameters:
        - sender: The UITextField for name input
    */
    @IBAction func enteredName(_ sender: UITextField) {
        if(sender.text != "" || sender.text != nil) {
            doneButton.isEnabled = true
        }
    }
    
    /**
     Dismisses the presenting view controller
    */
    @IBAction func cancelAdd(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveUnwindSegue" {
            objectForJournal.name = nameEntered.text
            objectForJournal.category = categorySelected.text
            objectForJournal.section = parameterToAdd
        }
    }

}

