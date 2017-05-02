//
//  AddViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 2/5/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var parameterToAdd = Int()
    
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
            topLabel.title = "Add"
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
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
