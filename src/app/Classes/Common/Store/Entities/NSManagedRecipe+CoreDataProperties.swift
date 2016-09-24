//
//  NSManagedRecipe+CoreDataProperties.swift
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

extension NSManagedRecipe {

    @NSManaged var details: String?
    @NSManaged var id: String?
    @NSManaged var images: String?
    @NSManaged var name: String?
    @NSManaged var raiting: NSNumber?
    @NSManaged var suitableForVegans: NSNumber?
    @NSManaged var vegans: NSNumber?
    @NSManaged var vegetarians: NSNumber?
    @NSManaged var categoryid: String?
    @NSManaged var localRelationship: NSManagedLocal?

}
