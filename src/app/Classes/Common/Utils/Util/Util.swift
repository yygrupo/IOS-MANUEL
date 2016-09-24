//
//  Util.swift
//  app
//
//  Created by Manuel Alejandro on 9/22/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import CoreLocation

class Utils: NSObject {
    
    class func recipeFromManagedEntity(entity: NSManagedRecipe) -> WRecipe {
        let id = entity.id
        let name = entity.name
        let raiting = entity.raiting?.intValue
        let images = entity.images?.componentsSeparatedByString(";")
        let details = entity.details
        let vegans = entity.vegans?.boolValue
        let vegetarians = entity.vegetarians?.boolValue
        let suitableForVegans = entity.suitableForVegans?.boolValue
        let category = entity.categoryid
        let local = localFromManagedEntity(entity.localRelationship!)
        
        return WRecipe(id: id, name: name, raiting: Int(raiting!), images: images, details: details, vegans: vegans, vegetarians: vegetarians, suitableForVegans: suitableForVegans, category: category, local: local)
    }
    
    class func categoryFromManagedEntity(entity: NSManagedCategory) -> WCategory {
        let id = entity.id
        let name = entity.name
        let image = entity.image
        
        return WCategory(id: id, name: name, image: image)
    }
    
    class func localFromManagedEntity(entity: NSManagedLocal) -> WLocal {
        let id = entity.id
        let name = entity.name
        let address = entity.address
        let phoneNumber = entity.phoneNumber
        let email = entity.email
        let details = entity.details
        var recipes: [WRecipe] = []
        let raiting = entity.raiting?.intValue
        let latitude = entity.latitude?.doubleValue
        let longitude = entity.longitude?.doubleValue
        
        for entityRecipe in entity.recipeRelationship! {
            let recipe = recipeFromManagedEntity(entityRecipe as! NSManagedRecipe)
            recipes.append(recipe)
        }
        
        return WLocal(id: id, name: name, address: address, phoneNumber: phoneNumber, email: email, details: details, recipes: recipes, raiting: Int(raiting!), image: entity.image, latitude: latitude, longitude: longitude)
    }
    
    class func calculateDistance(origin: CLLocation, destination: CLLocation) -> Double {
        return origin.distanceFromLocation(destination)
    }
}