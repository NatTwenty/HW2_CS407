//
//  EventViewController.swift
//  Hw2
//
//  Created by Dylan Homuth on 3/11/16.
//  Copyright © 2016 Dylan Homuth. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var discriptionField: UITextField!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var event: Event?
    var selectedDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventName.delegate = self
        discriptionField.delegate = self
        
        //if existing event
        if let event = event {
            navigationItem.title = event.name
            eventName.text   = event.name
            discriptionField.text = event.discription
            
            //preset date
            let dateString = event.date
            let df = NSDateFormatter()
            df.dateFormat = "dd-MM-yyyy HH:mm"
            let date = df.dateFromString(dateString)
            if let unwrappedDate = date {
                myDatePicker.setDate(unwrappedDate, animated: false)
            }
        }
        
        checkValidEventName()
    }
    
    //Navigation
    @IBAction func cancel(sender: AnyObject) {
        //figures out how page was opened
        let isPresentingInAddEventMode = presentingViewController is UINavigationController

        if isPresentingInAddEventMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = eventName.text ?? ""
            let discription = discriptionField.text ?? ""
            let date = selectedDate
            
            event = Event(name: name, date: date, discription: discription)
        }
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(myDatePicker.date)
        selectedDate = strDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UITextFieldDelegate
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidEventName() {
        // Disable the Save button if the text field is empty.
        let text = eventName.text ?? ""
        saveButton.enabled = !text.isEmpty
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //remove******
        //eventName.text = textField.text
        //discriptionField.text = textField.text
        
        checkValidEventName()
        navigationItem.title = eventName.text
    }


}

