//
//  LabelsViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class LabelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate/*, AddLabelDelegate*/, NSFetchedResultsControllerDelegate {
    
    var context : NSManagedObjectContext!
//    var labels = [Label]()
    var fetchedResultsController : NSFetchedResultsController!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Music Labels"

        // get the MoC from app delegate
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.context = appDelegate.managedObjectContext
        
        // setup the fetched results controller
        var request = NSFetchRequest(entityName: "Label")
        let sort = NSSortDescriptor(key: "name", ascending: true)

        // add sort to the request
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        
        // initialize the fetched results controller
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController.delegate = self
 
// no longer need this
//        // fetches the data stored
////        var request = NSFetchRequest(entityName: "Label")
//        var error : NSError?
//        self.labels = self.context.executeFetchRequest(request, error: &error) as [Label]
//        
//        if error != nil {
//            println(error?.localizedDescription)
//        } else {
//            self.tableView.reloadData()
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // perform fetch on appearance
        var error: NSError?
        fetchedResultsController.performFetch(&error)
        if error != nil {
            println("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addLabelButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("ToAddLabel", sender: self)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
//        return self.labels.count
        return self.fetchedResultsController!.sections[section].numberOfObjects
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath) as UITableViewCell

// moved below
//        var label = self.labels[indexPath.row]
//        cell.textLabel.text = label.name
        self.configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    // removes the selected cell (so on <back, original selected cell is no longer selected
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
// rewritten below
//     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if segue.identifier == "ToAddLabel" {
//            let addLabelVC = segue.destinationViewController as AddLabelViewController
//            addLabelVC.delegate = self
//        } else if segue.identifier == "ToArtists" {
//            let artistsVC = segue.destinationViewController as ArtistsViewController
//            artistsVC.selectedLabel = self.labels[self.tableView.indexPathForSelectedRow().row]
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ToArtists" {
            let artistsVC = segue.destinationViewController as ArtistsViewController
            var label = self.fetchedResultsController.fetchedObjects[self.tableView.indexPathForSelectedRow().row] as Label
            artistsVC.selectedLabel = label
        }
    }
    
    func configureCell(cell: UITableViewCell, forIndexPath indexPath: NSIndexPath) {
        var label = self.fetchedResultsController.fetchedObjects[indexPath.row] as Label
        cell.textLabel.text = label.name
    }
    
// no longer need this
//    func labelAdded() {
//        
//        // fetches the data stored
//        var request = NSFetchRequest(entityName: "Label")
//        var error : NSError?
//        self.labels = self.context.executeFetchRequest(request, error: &error) as [Label]
//        
//        if error != nil {
//            println(error?.localizedDescription)
//        } else {
//            self.tableView.reloadData()
//        }
//    }
    
    // MARK: NSFetchedResultsControllerDelegate Methods
    
    // called when an object is about ot change
    func controllerWillChangeContent(controller: NSFetchedResultsController!) {
        self.tableView.beginUpdates()
    }
    
    // called when an object is committed
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        self.tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
        
        switch type {
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(self.tableView.cellForRowAtIndexPath(indexPath), forIndexPath: indexPath)
        case .Move:
//            self.tableView.moveRowAtIndexPath([indexPath], toIndexPath: [newIndexPath]) // does this work?
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: TableView Delete Rows
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        // don't need anything here, but need this method for the following to work
    }
    
    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) -> [AnyObject]! {
        // delete action
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            if let labelForRow = self.fetchedResultsController.fetchedObjects[indexPath.row] as? Label {
                self.context.deleteObject(labelForRow)
                self.context.save(nil) // saves
            }
        }
        
        let moreAction = UITableViewRowAction(style: .Default, title: "More") { (action, indexPath) in
            println("More tapped")
        }
        
        deleteAction.backgroundColor = UIColor.redColor()
        moreAction.backgroundColor = UIColor.grayColor()
        
        return [deleteAction, moreAction]
    }
}