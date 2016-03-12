//
//  EventTableViewController.swift
//  Hw2
//
//  Created by Dylan Homuth on 3/11/16.
//  Copyright © 2016 Dylan Homuth. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    //properties
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load any saved events
        if let savedEvents = loadEvents() {
            events += savedEvents
        }
        
        navigationItem.leftBarButtonItem = editButtonItem()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        let event = events[indexPath.row]
        // Configure the cell
        cell.nameLab.text = event.name
        cell.dateLab.text = event.date

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            events.removeAtIndex(indexPath.row)
            saveEvents()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let eventDetailViewController = segue.destinationViewController as! EventViewController
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedMeal = events[indexPath.row]
                eventDetailViewController.event = selectedMeal
            }
        }
        else if segue.identifier == "AddItem" {
            //Nothing needs to happen here. Defult action
        }
    }
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EventViewController, event = sourceViewController.event {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing event
                events[selectedIndexPath.row] = event
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
                //Add new event
                let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
                events.append(event)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveEvents()
        }
    }
    
    //NSCodeing
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Error: Failed to save event!")
        }
    }

    func loadEvents() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]
    }

}
