//
//  ParametersTableViewController.swift
//  Richly
//
//  Created by Andrew Bellamy on 25/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData

class ParametersTableViewController: UITableViewController {

    //var params: [Parameter] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let selectionArray: [String] = ["People","Places","Activities","Weather","Chronology","Impact","Feelings","Experience"]
    
    var selectedParamter:Int? = nil
    var dataReceived: parameterObject!
    var journal: Journal?
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (journal == nil) {
            journal = Journal(context: context)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        //Place any other segue preps in here by identifier.
        if segue.identifier == "addParameter" {
            let toViewController = segue.destination as! AddViewController
            toViewController.parameterToAdd = (sender as AnyObject).tag
        }
    }
    
    @IBAction func unWind(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddViewController {
            dataReceived = sourceViewController.objectForJournal
        }
        let rowNumber = tableview.numberOfRows(inSection: dataReceived.section)
        switch dataReceived.section {
        case 0:
            let person = Person(context:context)
            person.name = dataReceived.name
            person.category = dataReceived.category
            journal?.addToPerson(person)
        case 1:
            let place = Place(context:context)
            place.name = dataReceived.name
            place.category = dataReceived.category
            journal?.addToPlace(place)
        case 2:
            let activity = Activity(context:context)
            activity.name = dataReceived.name
            activity.category = dataReceived.category
            journal?.addToActivity(activity)
        case 3:
            let weather = Weather(context:context)
            weather.name = dataReceived.name
            weather.category = dataReceived.category
            journal?.addToWeather(weather)
        case 4:
            let time = Time(context:context)
            time.name = dataReceived.name
            time.category = dataReceived.category
            journal?.addToTime(time)
        case 5:
            let impact = Impact(context:context)
            impact.name = dataReceived.name
            impact.category = dataReceived.category
            journal?.addToImpact(impact)
        case 6:
            let feeling = Feeling(context:context)
            feeling.name = dataReceived.name
            feeling.category = dataReceived.category
            journal?.addToFeeling(feeling)
        case 7:
            let consume = Consume(context:context)
            consume.name = dataReceived.name
            consume.category = dataReceived.category
            journal?.addToConsume(consume)
        default:
            print("No parameters have been returned.")
        }
        tableview.beginUpdates()
        tableview.insertRows(at: [IndexPath(row: rowNumber + 1, section: dataReceived.section)], with: .fade)
        tableview.endUpdates()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return selectionArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int ) -> String {
        return selectionArray[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
        cell.tag = indexPath.section
        return cell
    }
    
    /*
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        <#code#>
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Core Data Save and Retrieve
    func getParameters() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Parameter")
        
        let categorySort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchrequest.sortDescriptors = [categorySort]
        return fetchrequest
    }
}
