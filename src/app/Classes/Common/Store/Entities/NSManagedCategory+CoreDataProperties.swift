//
//  NSManagedCategory+CoreDataProperties.swift
//  app
//
//  Created by male on 9/25/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NSManagedCategory {

    @NSManaged var categoryid: String?
    @NSManaged var image: String?
    @NSManaged var name: String?

}
