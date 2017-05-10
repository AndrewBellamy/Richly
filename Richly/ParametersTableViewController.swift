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

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let selectionArray: [String] = ["People","Places","Activities","Weather","Chronology","Impact","Feelings","Experience"]
    var editCellRow: Int!
    var personArray: [Person] = []
    var placeArray: [Place] = []
    var activityArray: [Activity] = []
    var weatherArray: [Weather] = []
    var timeArray: [Time] = []
    var impactArray: [Impact] = []
    var feelingArray: [Feeling] = []
    var consumeArray: [Consume] = []
    
    var selectedParamter:Int? = nil
    var dataReceived: parameterObject!
    var journal: Journal?
    
    @IBOutlet var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(clearJournal),name: NSNotification.Name(rawValue: jDNotificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(postJournal),name: NSNotification.Name(rawValue: jGNotificationKey), object: nil)
        if (journal == nil) {
            journal = Journal(context: context)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func clearJournal() {
        context.delete(journal!)
    }
    
    func postJournal() {
        performSegue(withIdentifier: "generateRichText", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        //Place any other segue preps in here by identifier.
        if segue.identifier == "addParameter" {
            let toViewController = segue.destination as! AddViewController
            toViewController.parameterToAdd = (sender as AnyObject).tag
        }
        if segue.identifier == "editParameter" {
            let toViewController = segue.destination as! EditViewController
            let cell = (sender as AnyObject)
            editCellRow = tableView.indexPath(for: cell as! UITableViewCell)?.row
            let editSection = tableView.indexPath(for: cell as! UITableViewCell)!.section
            let editForJournal = parameterObject()
            editForJournal.section = editSection
            switch editSection {
            case 0:
                editForJournal.name = personArray[editCellRow].name!
                editForJournal.category = personArray[editCellRow].category!
            case 1:
                editForJournal.name = placeArray[editCellRow].name!
                editForJournal.category = placeArray[editCellRow].category!
            case 2:
                editForJournal.name = activityArray[editCellRow].name!
                editForJournal.category = activityArray[editCellRow].category!
            case 3:
                editForJournal.name = weatherArray[editCellRow].name!
                editForJournal.category = weatherArray[editCellRow].category!
            case 4:
                editForJournal.name = timeArray[editCellRow].name!
                editForJournal.category = timeArray[editCellRow].category!
            case 5:
                editForJournal.name = impactArray[editCellRow].name!
                editForJournal.category = impactArray[editCellRow].category!
            case 6:
                editForJournal.name = feelingArray[editCellRow].name!
                editForJournal.category = feelingArray[editCellRow].category!
            case 7:
                editForJournal.name = consumeArray[editCellRow].name!
                editForJournal.category = consumeArray[editCellRow].category!
            default:
                print("Section can not be edited")
            }
            
            toViewController.objectForJournal = editForJournal
        }
        if segue.identifier == "generateRichText" {
            let toViewController = segue.destination as! EditorViewController
            toViewController.journal = journal
        }
    }
    
    @IBAction func unWind(segue: UIStoryboardSegue) {
        if(segue.identifier == "saveUnwindSegue") {
            let sourceViewController = segue.source as! AddViewController
            dataReceived = sourceViewController.objectForJournal
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
        if(segue.identifier == "changeUnwindSegue") {
            let sourceViewController = segue.source as! EditViewController
            dataReceived = sourceViewController.objectForJournal
            switch dataReceived.section {
            case 0:
                let oldPerson = personArray[editCellRow]
                journal?.removeFromPerson(oldPerson)
                let person = Person(context:context)
                person.name = dataReceived.name
                person.category = dataReceived.category
                journal?.addToPerson(person)
            case 1:
                let oldPlace = placeArray[editCellRow]
                journal?.removeFromPlace(oldPlace)
                let place = Place(context:context)
                place.name = dataReceived.name
                place.category = dataReceived.category
                journal?.addToPlace(place)
            case 2:
                let oldActivity = activityArray[editCellRow]
                journal?.removeFromActivity(oldActivity)
                let activity = Activity(context:context)
                activity.name = dataReceived.name
                activity.category = dataReceived.category
                journal?.addToActivity(activity)
            case 3:
                let oldWeather = weatherArray[editCellRow]
                journal?.removeFromWeather(oldWeather)
                let weather = Weather(context:context)
                weather.name = dataReceived.name
                weather.category = dataReceived.category
                journal?.addToWeather(weather)
            case 4:
                let oldTime = timeArray[editCellRow]
                journal?.removeFromTime(oldTime)
                let time = Time(context:context)
                time.name = dataReceived.name
                time.category = dataReceived.category
                journal?.addToTime(time)
            case 5:
                let oldImpact = impactArray[editCellRow]
                journal?.removeFromImpact(oldImpact)
                let impact = Impact(context:context)
                impact.name = dataReceived.name
                impact.category = dataReceived.category
                journal?.addToImpact(impact)
            case 6:
                let oldFeeling = feelingArray[editCellRow]
                journal?.removeFromFeeling(oldFeeling)
                let feeling = Feeling(context:context)
                feeling.name = dataReceived.name
                feeling.category = dataReceived.category
                journal?.addToFeeling(feeling)
            case 7:
                let oldConsume = consumeArray[editCellRow]
                journal?.removeFromConsume(oldConsume)
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
    
    // MARK: - Table view data source and delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
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
                personArray = Array(person!) as! [Person]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (personArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (personArray[indexPath.row] as AnyObject).name
                return cell
            case 1:
                let place = journal?.place
                placeArray = Array(place!) as! [Place]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (placeArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (placeArray[indexPath.row] as AnyObject).name
                return cell
            case 2:
                let activity = journal?.activity
                activityArray = Array(activity!) as! [Activity]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (activityArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (activityArray[indexPath.row] as AnyObject).name
                return cell
            case 3:
                let weather = journal?.weather
                weatherArray = Array(weather!) as! [Weather]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (weatherArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (weatherArray[indexPath.row] as AnyObject).name
                return cell
            case 4:
                let time = journal?.time
                timeArray = Array(time!) as! [Time]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (timeArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (timeArray[indexPath.row] as AnyObject).name
                return cell
            case 5:
                let impact = journal?.impact
                impactArray = Array(impact!) as! [Impact]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (impactArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (impactArray[indexPath.row] as AnyObject).name
                return cell
            case 6:
                let feeling = journal?.feeling
                feelingArray = Array(feeling!) as! [Feeling]
                let cell = tableView.dequeueReusableCell(withIdentifier: "ParameterCell", for: indexPath)
                cell.textLabel?.text = (feelingArray[indexPath.row] as AnyObject).category
                cell.detailTextLabel?.text = (feelingArray[indexPath.row] as AnyObject).name
                return cell
            case 7:
                let consume = journal?.consume
                consumeArray = Array(consume!) as! [Consume]
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var edit = Bool()
        switch indexPath.section {
        case 0:
            if(indexPath.row != (personArray.count)) {
                edit = true
            } else {
                edit = false
            }
        case 1:
            if(indexPath.row != (placeArray.count)) {
                edit = true
            } else {
                edit = false
            }
        case 2:
            if(indexPath.row != (activityArray.count)) {
                edit = true
            } else {
                edit = false
            }
        case 3:
            if(indexPath.row != (weatherArray.count)) {
                edit = true
            } else {
                edit = false
            }
        case 4:
            if(indexPath.row != (timeArray.count)) {
                edit = true
            } else {
                edit = false
            }
        case 5:
            if(indexPath.row != (impactArray.count)) {
                edit = true
            } else {
                edit = false
            }
        case 6:
            if(indexPath.row != (feelingArray.count)) {
                edit = true
            } else {
                edit = false
            }
        case 7:
            if(indexPath.row != (consumeArray.count)) {
                edit = true
            } else {
                edit = false
            }
        default:
            edit = false
        }
        return edit
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                let oldPerson = personArray[indexPath.row]
                journal?.removeFromPerson(oldPerson)
            case 1:
                let oldPlace = placeArray[indexPath.row]
                journal?.removeFromPlace(oldPlace)
            case 2:
                let oldActivity = activityArray[indexPath.row]
                journal?.removeFromActivity(oldActivity)
            case 3:
                let oldWeather = weatherArray[indexPath.row]
                journal?.removeFromWeather(oldWeather)
            case 4:
                let oldTime = timeArray[indexPath.row]
                journal?.removeFromTime(oldTime)
            case 5:
                let oldImpact = impactArray[indexPath.row]
                journal?.removeFromImpact(oldImpact)
            case 6:
                let oldFeeling = feelingArray[indexPath.row]
                journal?.removeFromFeeling(oldFeeling)
            case 7:
                let oldConsume = consumeArray[indexPath.row]
                journal?.removeFromConsume(oldConsume)
            default:
                print("Nothing to remove")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Core Data Retrieve and Delete
    func getParameters() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Parameter")
        
        let categorySort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchrequest.sortDescriptors = [categorySort]
        return fetchrequest
    }
}
