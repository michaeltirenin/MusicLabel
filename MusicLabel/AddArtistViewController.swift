//
//  AddArtistViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

class AddArtistViewController: UIViewController, UITextFieldDelegate {

    var context : NSManagedObjectContext!
    var selectedLabel : Label?

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add Recording Artist"
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveArtistButton(sender: UIBarButtonItem) {
        
        var labelContext = self.selectedLabel?.managedObjectContext
        
        var newArtist = NSEntityDescription.insertNewObjectForEntityForName("Artist", inManagedObjectContext: labelContext) as Artist
        newArtist.firstName = self.firstNameTextField.text
        newArtist.lastName = self.lastNameTextField.text
        newArtist.label = self.selectedLabel!
        
        var error : NSError?
        labelContext?.save(&error)
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.navigationController.popViewControllerAnimated(true)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
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
