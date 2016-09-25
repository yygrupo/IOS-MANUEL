//
//  WHomeDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WHomeDataManager: NSObject
{
    var dataStore: WCoreDataStore?
    
    func findRecipesWithCategory(categoryId: String, completion:((recipes: [WRecipe]?) -> Void)?) {
        let predicate = NSPredicate(format: "categoryid = %@", categoryId)
        dataStore?.fetchEntriesForEntityName("Recipe", predicate: predicate, sortDescriptors: [], completion: { (results) in
            var recipes = [WRecipe]()
            for entityObject in results {
                let managedObject = entityObject as? NSManagedRecipe
                if managedObject == nil {
                    continue
                }
                let recipe = Utils.recipeFromManagedEntity(entityObject as! NSManagedRecipe)
                recipes.append(recipe)
            }
            if completion != nil {
                completion!(recipes: recipes)
            }
        })
    }
    
    func findLocalFromRecipe(recipe: WRecipe, completion: ((local: WLocal?) -> Void)?) {
        var recipeLocal = WLocal()
        
        let predicate = NSPredicate(format: "localid = %@", (recipe.local?.id)!)
        dataStore?.fetchEntriesForEntityName("Local", predicate: predicate, sortDescriptors: [], completion: { (results) in
            if results.count > 0 {
                let mamangedLocal = results[0] as! NSManagedLocal
                recipeLocal = Utils.localFromManagedEntity(mamangedLocal)
                if completion != nil {
                    completion!(local: recipeLocal)
                }
            } else {
                if completion != nil {
                    completion!(local: recipeLocal)
                }
            }
        })
    }
    
    func findRecipes(completion:((recipes: [WRecipe]?) -> Void)?) {
        dataStore?.fetchEntriesForEntityName("Recipe", predicate: nil, sortDescriptors: [], completion: { (results) in
            var recipes = [WRecipe]()
            for entityObject in results {
                let managedObject = entityObject as? NSManagedRecipe
                if managedObject == nil {
                    continue
                }
                let recipe = Utils.recipeFromManagedEntity(entityObject as! NSManagedRecipe)
                recipes.append(recipe)
            }
            if completion != nil {
                completion!(recipes: recipes)
            }
        })
    }
    
    func findCategories(completion:((categories: [WCategory]?) -> Void)?) {
        dataStore?.fetchEntriesForEntityName("Category", predicate: nil, sortDescriptors: [], completion: { (results) in
            var categories = [WCategory]()
            for entityObject in results {
                let category = Utils.categoryFromManagedEntity(entityObject as! NSManagedCategory)
                categories.append(category)
            }
            if completion != nil {
                completion!(categories: categories)
            }
        })
    }
    
    func saveCategories(categories: [WCategory], completion: (() -> Void)?) {
        for category in categories {
            let managedCategory = dataStore?.newManagedCategory()
            managedCategory?.categoryid = category.id
            managedCategory?.name = category.name
            managedCategory?.image = category.image
        }
        dataStore?.saveContext()
        
        if completion != nil {
            completion!()
        }
    }
    
    func saveLocals(locals: [WLocal], completion: (() -> Void)?) {
        for local in locals {
            let managedLocal = dataStore?.newManagedLocal()
            managedLocal?.address = local.address
            managedLocal?.details = local.details
            managedLocal?.email = local.email
            managedLocal?.localid = local.id
            managedLocal?.image = local.image
            managedLocal?.name = local.name
            managedLocal?.phoneNumber = local.phoneNumber
            managedLocal?.raiting = NSNumber(integer: local.raiting!)
            managedLocal?.image = local.image
            managedLocal?.latitude = local.latitude
            managedLocal?.longitude = local.longitude
            
            for recipe in local.recipes! {
                let managedRecipe = dataStore?.newManagedRecipe()
                managedRecipe?.categoryid = recipe.category
                managedRecipe?.details = recipe.details
                managedRecipe?.recipeid = recipe.id
                managedRecipe?.images = recipe.images?.joinWithSeparator(";")
                managedRecipe?.localid = local.id
                managedRecipe?.name = recipe.name
                managedRecipe?.vegans = NSNumber(bool: recipe.vegans!)
                managedRecipe?.vegetarians = NSNumber(bool: recipe.vegetarians!)
                managedRecipe?.celiacs = NSNumber(bool: recipe.celiacs!)
                managedRecipe?.favorite = NSNumber(bool: false)
                managedRecipe?.tasted = NSNumber(bool: false)
                managedRecipe?.rating = NSNumber(integer: recipe.rating!)
            }
        }
        dataStore?.saveContext()
        
        if completion != nil {
            completion!()
        }
    }
}
