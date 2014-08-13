//
//  ViewController.swift
//  Person Array iOS
//
//  Created by Cameron Klein on 8/7/14.
//  Copyright (c) 2014 Cameron Klein. All rights reserved.
//

import UIKit
import Foundation



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    //Properties
    @IBOutlet weak var tableView: UITableView!
    var personArray = [[Person]]()
    
    //START Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initializePersonArray()
        
        for array in personArray{
            for person in array{
                println(person.fullName())
            }
        }
        
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        let index = tableView.indexPathForSelectedRow()
        let selectedPerson = personArray[index.section][index.row]
        if segue.identifier! == "Detail" {
            let destination = segue.destinationViewController as DetailViewController
            destination.thisPerson = selectedPerson
        }
    }
    
    // END Override Functions
    // START Custom Functions
    
    func initializePersonArray(){
        
        //Get property list
        let path = NSBundle.mainBundle().pathForResource("Roster", ofType:"plist")
        let array = NSArray(contentsOfFile:path)
    
        var teacherArray = [Person]()
        var studentArray = [Person]()
        
        for person in array{
            
            var thisFirst = person["firstName"] as String
            var thisLast = person["lastName"] as String
            var imagePath = person["image"] as String
            var thisImage = UIImage(named: imagePath) as UIImage
            var thisPosition = person["position"] as String
            var thisPerson = Person(firstName: thisFirst, lastName: thisLast, image: thisImage, position: thisPosition)
            if thisPosition == "Teacher"{
                teacherArray.append(thisPerson)
            } else if thisPosition == "Student"{
                studentArray.append(thisPerson)
            }
            
        }
        studentArray.sort { $0.firstName < $1.firstName }
        teacherArray.sort { $0.firstName < $1.firstName }
        self.personArray.append(studentArray)
        self.personArray.append(teacherArray)
        
        
        
    }
    
    //END Custom Functions
    //START DataSource Protocol Functions
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
       return personArray[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return personArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        

        var thisPerson = self.personArray[indexPath.section][indexPath.row]
        
        cell.textLabel.text = thisPerson.fullName()

        
        return cell
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        switch section {
        case 0: return "Students"
        case 1: return "Teachers"
        default: return " "
        
        }
    }
    
    //END DataSource Protocol Functions


}

