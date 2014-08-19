//
//  Song.swift
//  MusicLabel
//
//  Created by Michael Tirenin on 8/19/14.
//  Copyright (c) 2014 Michael Tirenin. All rights reserved.
//

import Foundation
import CoreData

class Song: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var year: NSNumber
    @NSManaged var artist: Artist // changed from NSManagedObject to Artist

}
