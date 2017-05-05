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
        NotificationCenter.default.addObserver(self, selector: #selector(clearJournal),name: NSNotification.Name(rawValue: jDNotificationKey), object: nil)
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
        if(segue.identifier == "saveUnwindSegue") {
            let sourceViewController = segue.source as! AddViewController
            dataReceived = sourceViewController.objectForJournal
            //let rowNumber = tableview.numberOfRows(inSection: dataReceived.section)
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
            tableview.reloadData()
        }
        
    }

    func clearJournal() {
        context.delete(journal!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
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
        var relArray : [Any] = []
        switch section {
        case 0:
            let person = journal?.person
            relArray = Array(person!)
        case 1:
            let place = journal?.place
            relArray = Array(place!)
        case 2:
            let activity = journal?.activity
            relArray = Array(activity!)
        case 3:
            let weather = journal?.weather
            relArray = Array(weather!)
        case 4:
            let time = journal?.time
            relArray = Array(time!)
        case 5:
            let impact = journal?.impact
            relArray = Array(impact!)
        case 6:
            let feeling = journal?.feeling
            relArray = Array(feeling!)
        case 7:
            let consume = journal?.consume
            relArray = Array(consume!)
        default:
            print("Error: new section has been included")
        }
        return 1 + relArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowsInSection = tableView.numberOfRows(inSection: indexPath.section) - 1
        while indexPath.row != rowsInSection {
            switch indexPath.section {
            case 0:
                let person = journal?.person
                let personArray: [Person] = Array(person!) as! [Person]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (personArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (personArray[indexPath.row] as AnyObject).name
                return cell
            case 1:
                let place = journal?.place
                let placeArray: [Place] = Array(place!) as! [Place]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (placeArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (placeArray[indexPath.row] as AnyObject).name
                return cell
            case 2:
                let activity = journal?.activity
                let activityArray: [Activity] = Array(activity!) as! [Activity]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (activityArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (activityArray[indexPath.row] as AnyObject).name
                return cell
            case 3:
                let weather = journal?.weather
                let weatherArray: [Weather] = Array(weather!) as! [Weather]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (weatherArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (weatherArray[indexPath.row] as AnyObject).name
                return cell
            case 4:
                let time = journal?.time
                let timeArray: [Time] = Array(time!) as! [Time]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (timeArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (timeArray[indexPath.row] as AnyObject).name
                return cell
            case 5:
                let impact = journal?.impact
                let impactArray: [Impact] = Array(impact!) as! [Impact]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (impactArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (impactArray[indexPath.row] as AnyObject).name
                return cell
            case 6:
                let feeling = journal?.feeling
                let feelingArray: [Feeling] = Array(feeling!) as! [Feeling]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (feelingArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (feelingArray[indexPath.row] as AnyObject).name
                return cell
            case 7:
                let consume = journal?.consume
                let consumeArray: [Consume] = Array(consume!) as! [Consume]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (consumeArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (consumeArray[indexPath.row] as AnyObject).name
                return cell
            default:
                print("No section to add cells to")
            }
        }
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
