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
    var personArray = [Person]()
    
    //START Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initializePersonArray()
        
        for person in personArray{
            println(person.fullName())
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
        let selectedPerson = personArray[index.row]
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
        let dict = NSDictionary(contentsOfFile:path)
        
        var tempArray = dict["Roster"] as Array<String>
        
        for person in tempArray{
            self.personArray.append(Person(fullName: person))
        }
        
        for person in personArray{
            if person.lastName == "Klein"{
                
            person.image = UIImage(named: "cameron.jpg")
            }
        }
    }
    
    //END Custom Functions
    //START DataSource Protocol Functions
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        personArray.sort { $0.firstName < $1.firstName }
        
        cell.textLabel.text = self.personArray[indexPath.row].fullName()
        
        return cell
    }
    
    //END DataSource Protocol Functions


}

