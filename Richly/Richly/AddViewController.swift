//
//  AddViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 2/5/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var parameterToAdd = Int()
    var objectForJournal = parameterObject()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var personCategory: [String] = ["Friend","Family"]
    var placeCategory: [String] = ["Home","Outdoors"]
    var activityCategory: [String] = ["Past Tense","Present Tense"]
    var weatherCategory: [String] = ["Temperature","Sky"]
    var timeCategory: [String] = ["Interval","Event"]
    var impactCategory: [String] = ["Problem","Solution"]
    var feelingCategory: [String] = ["Emotion","Reaction"]
    var consumeCategory: [String] = ["Food","Information","Visual","Audial"]
    var currentCategory: [String] = []

    @IBOutlet weak var topLabel: UIBarButtonItem!
    @IBOutlet weak var categorySelected: UILabel!
    @IBOutlet weak var nameEntered: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        switch parameterToAdd {
        case 0:
            topLabel.title = "Add Person"
            currentCategory = personCategory
        case 1:
            topLabel.title = "Add Place"
            currentCategory = placeCategory
        case 2:
            topLabel.title = "Add Activity"
            currentCategory = activityCategory
        case 3:
            topLabel.title = "Add Weather"
            currentCategory = weatherCategory
        case 4:
            topLabel.title = "Add Time"
            currentCategory = timeCategory
        case 5:
            topLabel.title = "Add Impact"
            currentCategory = impactCategory
        case 6:
            topLabel.title = "Add Feeling"
            currentCategory = feelingCategory
        case 7:
            topLabel.title = "Add Experience"
            currentCategory = consumeCategory
        default:
            cancelAdd((Any).self)
        }
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
        nameEntered.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameEntered {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveUnwindSegue" {
            objectForJournal.name = nameEntered.text
            objectForJournal.category = categorySelected.text
            objectForJournal.section = parameterToAdd
        }
    }

}

