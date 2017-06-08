//
//  ViewController.swift
//  Database
//
//  Created by Zachary William Lipsky on 6/7/17.
//  Copyright © 2017 Zachary William Lipsky. All rights reserved.
//

import UIKit

// Establish variables
struct post { //Ingredient
    let title : String! //Name
    let message : String! //Information
}

class TableViewController: UITableViewController {

    var posts = [post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Grab data from database
    let databaseRef = FIRDatabase.database().reference()
    
    //Everytime child is added
    databaseRef.child("Posts").queryOrderedByKey().observeEventType(.ChildAdded), withBlock: { snapshot in
    
    let title = snapshot.value!["title"] as! String
    let message = snapshot.value!["message"] as! String
    
    self.posts.insert(postStruct(title: title , message: message), at Index: 0)
    self.tableView.reloadData()
    })
    
//    func post(){
//        let title = "Title"
//        let message = "Message"
//        // Reference database
//        let databaseRef = Database.database().reference()
//        // Access certain part of project
//        databaseRef.child("Posts").childByAutoId().setValue(post)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return post.count
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].title
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[indexPath.row].message
        return cell!
    

}

