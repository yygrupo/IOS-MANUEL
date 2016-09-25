//
//  NSManagedRecipe+CoreDataProperties.swift
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

extension NSManagedRecipe {

    @NSManaged var categoryid: String?
    @NSManaged var details: String?
    @NSManaged var favorite: NSNumber?
    @NSManaged var images: String?
    @NSManaged var localid: String?
    @NSManaged var name: String?
    @NSManaged var rating: NSNumber?
    @NSManaged var recipeid: String?
    @NSManaged var celiacs: NSNumber?
    @NSManaged var tasted: NSNumber?
    @NSManaged var vegans: NSNumber?
    @NSManaged var vegetarians: NSNumber?

}
