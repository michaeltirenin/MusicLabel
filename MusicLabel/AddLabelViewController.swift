//
//  AddLabelViewController.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import UIKit
import CoreData

//protocol AddLabelDelegate {
//    func labelAdded()
//}

class AddLabelViewController: UIViewController, UITextFieldDelegate {

    var context : NSManagedObjectContext!

    @IBOutlet weak var labelNameTextField: UITextField!
    
//    var delegate : AddLabelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add Music Label"
        labelNameTextField.delegate = self
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.context = appDelegate.managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveLabelButton(sender: UIBarButtonItem) {
        
        // insert data object
        var newLabel = NSEntityDescription.insertNewObjectForEntityForName("Label", inManagedObjectContext: self.context) as Label
        newLabel.name = self.labelNameTextField.text
        
        var error : NSError?
        self.context.save(&error)
        if error != nil {
            println(error?.localizedDescription)
        }
//        } else {
//            self.delegate?.labelAdded()
//            self.navigationController.popToRootViewControllerAnimated(true)
//        }
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
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