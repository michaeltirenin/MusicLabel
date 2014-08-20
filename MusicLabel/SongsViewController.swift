//
//  SongsViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class SongsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var songs = [Song]()
    var selectedArtist : Artist?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Songs"

        // tableview
        self.songs = self.selectedArtist!.songs.allObjects as [Song]
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addSongButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("ToAddSong", sender: self)
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath) as UITableViewCell
        
        var song = self.songs[indexPath.row]
        cell.textLabel.text = song.title
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ToAddSong" {
            let addSongVC = segue.destinationViewController as AddSongViewController
            addSongVC.selectedArtist = selectedArtist
        }
    }
}
