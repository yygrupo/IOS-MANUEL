//
//  Util.swift
//  app
//
//  Created by Manuel Alejandro on 9/22/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class Utils: NSObject {
    
    class func categoryByRecipeCategory(categoryId: String) -> WCategory {
        let categories = WMainBoard.sharedInstance.categories
        var category = WCategory()
        for categoryEntity in categories {
            if categoryEntity.id == categoryId {
                category = categoryEntity
                break
            }
        }
        return category
    }
    
    class func recipeFromManagedEntity(entity: NSManagedRecipe) -> WRecipe {
        let id = entity.recipeid
        let name = entity.name
        let rating = entity.rating?.intValue
        let images = entity.images?.componentsSeparatedByString(";")
        let details = entity.details
        let vegans = entity.vegans?.boolValue
        let vegetarians = entity.vegetarians?.boolValue
        let celiacs = entity.celiacs?.boolValue
        let category = entity.categoryid
        var local = WLocal()
        local.id = entity.localid
        let tasted = entity.tasted?.boolValue
        let favorite = entity.favorite?.boolValue
        
        return WRecipe(id: id, name: name, rating: Int(rating!), images: images, details: details, vegans: vegans, vegetarians: vegetarians, celiacs: celiacs, category: category, local: local, tasted: tasted, favorite: favorite)
    }
    
    class func categoryFromManagedEntity(entity: NSManagedCategory) -> WCategory {
        let id = entity.categoryid
        let name = entity.name
        let image = entity.image
        
        return WCategory(id: id, name: name, image: image)
    }
    
    class func localFromManagedEntity(entity: NSManagedLocal) -> WLocal {
        let id = entity.localid
        let name = entity.name
        let address = entity.address
        let phoneNumber = entity.phoneNumber
        let email = entity.email
        let details = entity.details
        let raiting = entity.raiting?.intValue
        let latitude = entity.latitude?.doubleValue
        let longitude = entity.longitude?.doubleValue
        
        return WLocal(id: id, name: name, address: address, phoneNumber: phoneNumber, email: email, details: details, recipes: [], raiting: Int(raiting!), image: entity.image, latitude: latitude, longitude: longitude)
    }
    
    class func calculateDistance(origin: CLLocation, destination: CLLocation) -> Double {
        return origin.distanceFromLocation(destination)
    }
}