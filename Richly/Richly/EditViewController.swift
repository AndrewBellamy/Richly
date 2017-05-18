//
//  EditViewController.swift
//  Richly
//
//  Created by Andrew Bellamy : 215240036 on 6/5/17.
//  SIT206 Assignment 2
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    /**
     Initialization variables
    */
    var objectForJournal: parameterObject!
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
        switch objectForJournal.section {
        case 0:
            topLabel.title = "Edit Person"
            currentCategory = CategoryFarm.personCategory
        case 1:
            topLabel.title = "Edit Place"
            currentCategory = CategoryFarm.placeCategory
        case 2:
            topLabel.title = "Edit Activity"
            currentCategory = CategoryFarm.activityCategory
        case 3:
            topLabel.title = "Edit Weather"
            currentCategory = CategoryFarm.weatherCategory
        case 4:
            topLabel.title = "Edit Time"
            currentCategory = CategoryFarm.timeCategory
        case 5:
            topLabel.title = "Edit Impact"
            currentCategory = CategoryFarm.impactCategory
        case 6:
            topLabel.title = "Edit Feeling"
            currentCategory = CategoryFarm.feelingCategory
        case 7:
            topLabel.title = "Edit Experience"
            currentCategory = CategoryFarm.consumeCategory
        default:
            cancelEdit((Any).self)
        }
        categoryPicker.selectRow(currentCategory.index(of: objectForJournal.category)!, inComponent: 0, animated: true)
        nameEntered.text = objectForJournal.name
        categorySelected.text = objectForJournal.category
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
     Dismisses the presenting view controller
     */
    @IBAction func cancelEdit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeUnwindSegue" {
            objectForJournal.name = nameEntered.text
            objectForJournal.category = categorySelected.text
        }
    }
    
}


