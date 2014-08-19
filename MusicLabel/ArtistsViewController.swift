//
//  ArtistViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class ArtistsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var context : NSManagedObjectContext!
    var artists = [Artist]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Recording Artists"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func addArtistButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("ToAddArtist", sender: self)
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.artists.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistCell", forIndexPath: indexPath) as UITableViewCell
        
        var artist = self.artists[indexPath.row]
        cell.textLabel.text = artist.firstName + " " + artist.lastName
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ToAddArtist" {
            let addLabelVC = segue.destinationViewController as AddArtistViewController
            //            addLabelVC.delegate = self
        } else if segue.identifier == "ToSongs" {
            let artistsVC = segue.destinationViewController as SongsViewController
        }
    }

}
