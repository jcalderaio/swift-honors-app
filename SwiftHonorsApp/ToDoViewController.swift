//
//  ToDoViewController.swift
//  SwiftHonorsApp
//
//  Created by John Calderaio on 10/17/16.
//  Copyright © 2016 John Calderaio. All rights reserved.
//

import UIKit

var toDoList = [String]()

class ToDoViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    
    //  These functions are for the addition of new items
    
    
    @IBAction func addItem(sender: AnyObject) {
        if item.text != nil {
            
            //  Add item to array
            toDoList.append(item.text!)
            
            //  Add item to user defaults
            NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
            item.text = ""
            
            //  Update Tableview
            
            /*
             *  TODO: The table view on the screen is not being updated after adding to array
             */
            
            
        
        }
    }
    
    
    @IBOutlet var item: UITextField!
    
    @IBOutlet var toDoListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //****  ADD IN EVERY APP FOR KERYBOARD!
        self.item.delegate = self
        
        // If a toDoList was stored from a previous session, this restores that session
        if NSUserDefaults.standardUserDefaults().objectForKey("toDoList") != nil {
            toDoList = NSUserDefaults.standardUserDefaults().objectForKey("toDoList") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //****  ADD IN EVERY APP FOR KERYBOARD!
    //Close the keyboard when touch outside keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //****  ADD IN EVERY APP FOR KERYBOARD!
    //********Add this function to close keyboard when user presses return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        item.resignFirstResponder()
        return true
    }
    
    
    
    
    //  These functions are for the Table View
    
    
    //Returns the amount of rows to be in tableview. Std Tableview function
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count   //Returns the exact count of how many items are in the array
    }
    
    //Returns the exact row in repeat. Like ng-repeat
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = toDoList[indexPath.row]   //Returns the index of our toDoList array
        return cell
    }
    
    //Swipe left to permanently delete item in table AND array
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //print("before: \(toDoList.count)")
        //print(toDoList)
        if editingStyle == .Delete {
            toDoList.removeAtIndex(indexPath.row)
            
            //Delete item from array
            NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
}
