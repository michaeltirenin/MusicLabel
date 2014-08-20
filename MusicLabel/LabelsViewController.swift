//
//  LabelsViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class LabelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddLabelDelegate {
    
    var context : NSManagedObjectContext!
    var labels = [Label]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Music Labels"

        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.context = appDelegate.managedObjectContext
        
        // fetches the data stored
        var request = NSFetchRequest(entityName: "Label")
        var error : NSError?
        self.labels = self.context.executeFetchRequest(request, error: &error) as [Label]
        
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addLabelButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("ToAddLabel", sender: self)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.labels.count
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath) as UITableViewCell
        
        var label = self.labels[indexPath.row]
        cell.textLabel.text = label.name
        
        return cell
    }
    
    // MARK: - Navigation

     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ToAddLabel" {
            let addLabelVC = segue.destinationViewController as AddLabelViewController
            addLabelVC.delegate = self
        } else if segue.identifier == "ToArtists" {
            let artistsVC = segue.destinationViewController as ArtistsViewController
            artistsVC.selectedLabel = self.labels[self.tableView.indexPathForSelectedRow().row]
        }
    }
    
    func labelAdded() {
        
        // fetches the data stored
        var request = NSFetchRequest(entityName: "Label")
        var error : NSError?
        self.labels = self.context.executeFetchRequest(request, error: &error) as [Label]
        
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.tableView.reloadData()
        }
    }
}