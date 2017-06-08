//
//  ViewController.swift
//  Database
//
//  Created by Zachary William Lipsky on 6/7/17.
//  Copyright © 2017 Zachary William Lipsky. All rights reserved.
//

import UIKit
import CoreData

class tableViewController: UITableViewController {
    //List list items everything in coredata
    var listItems = [NSManagedObject]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Saving
    func saveItem(itemToSave: String){
        //Controls how item saves
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //Saving into coredata
        let managedContext = appDelegate.manangedObjectContext
        
        let ingredient = NSEntityDescrption.entityForName("Ingredient", inManagedObjectContext: managedContext)
        let name = NSManagedObject(ingredient:ingredient!, insertIntoManagedObjectContect: managedContext)
        name.setValue(itemToSave,forKey: "name")
        do{
            try managedContect.save()
            listItems.append(item)
        }
        catch{
            print("error")
        }
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Etablish tableview amount of rows is equal to number of times in coredata
    override func tableView(tableView: UITableView, numberOfRowsinSection section: Int) -> Int {
        return listItems.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!as UITableViewCell
        return cell
    }
}

//    let item = listItem(indexPath.row)

//    let label1 = cell?.viewWithTag(1) as! UILabel
