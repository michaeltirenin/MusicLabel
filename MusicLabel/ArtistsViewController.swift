//
//  ArtistViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class ArtistsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddArtistDelegate {

    var artists = [Artist]()
    var selectedLabel : Label?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Recording Artists"
        
        self.artists = self.selectedLabel!.artists.allObjects as [Artist]
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
            let addArtistVC = segue.destinationViewController as AddArtistViewController
            addArtistVC.selectedLabel = selectedLabel
            addArtistVC.delegate = self
        } else if segue.identifier == "ToSongs" {
            let artistsVC = segue.destinationViewController as SongsViewController
            artistsVC.selectedArtist = self.artists[self.tableView.indexPathForSelectedRow().row]

        }
    }
    
    func artistAdded() {
        self.artists = self.selectedLabel!.artists.allObjects as [Artist]
        self.tableView.reloadData()
    }
}