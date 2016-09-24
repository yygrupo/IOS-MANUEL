//
//  NSManagedLocal+CoreDataProperties.swift
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

extension NSManagedLocal {

    @NSManaged var address: String?
    @NSManaged var details: String?
    @NSManaged var email: String?
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var raiting: NSNumber?
    @NSManaged var image: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var recipeRelationship: NSSet?

}
