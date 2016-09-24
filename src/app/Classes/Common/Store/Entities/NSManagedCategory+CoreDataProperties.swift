//
//  NSManagedCategory+CoreDataProperties.swift
//  app
//
//  Created by Manuel Alejandro on 9/23/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NSManagedCategory {

    @NSManaged var id: String?
    @NSManaged var image: String?
    @NSManaged var name: String?

}
