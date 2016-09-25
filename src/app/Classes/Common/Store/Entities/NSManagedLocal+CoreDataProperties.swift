//
//  NSManagedLocal+CoreDataProperties.swift
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

extension NSManagedLocal {

    @NSManaged var address: String?
    @NSManaged var details: String?
    @NSManaged var email: String?
    @NSManaged var image: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var localid: String?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var raiting: NSNumber?

}
