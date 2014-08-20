//
//  AddSongViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class AddSongViewController: UIViewController, UITextFieldDelegate {

    var selectedArtist : Artist?
    var songs = [Song]()
    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add Song"
        songTitleTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(animated: Bool) {
    }
    
    @IBAction func saveSongButton(sender: UIBarButtonItem) {
        
        var artistContext = self.selectedArtist?.managedObjectContext
        
        var newSong = NSEntityDescription.insertNewObjectForEntityForName("Song", inManagedObjectContext: artistContext) as Song
        newSong.title = self.songTitleTextField.text
        newSong.artist = self.selectedArtist!
        
        var error : NSError?
        artistContext?.save(&error)
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.navigationController.popViewControllerAnimated(true)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        songTitleTextField.resignFirstResponder()
        return true
    }
    
    // resigns keyboard if any touch happens in white space
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        for control in self.view.subviews {
            if let theControl = control as? UITextField {
                theControl.resignFirstResponder()
            }
        }
    }

}