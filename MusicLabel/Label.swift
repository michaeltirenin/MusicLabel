//
//  Label.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import Foundation
import CoreData

class Label: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var artists: NSSet

}
