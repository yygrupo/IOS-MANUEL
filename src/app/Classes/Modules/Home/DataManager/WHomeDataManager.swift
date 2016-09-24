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
            managedCategory?.id = category.id
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
            managedLocal?.id = local.id
            managedLocal?.image = local.image
            managedLocal?.name = local.name
            managedLocal?.phoneNumber = local.phoneNumber
            managedLocal?.raiting = NSNumber(integer: local.raiting!)
            managedLocal?.image = local.image
            for recipe in local.recipes! {
                let managedRecipe = dataStore?.newManagedRecipe()
                managedRecipe?.categoryid = recipe.category
                managedRecipe?.details = recipe.details
                managedRecipe?.id = recipe.id
                managedRecipe?.images = recipe.images?.joinWithSeparator(";")
                managedRecipe?.localRelationship = managedLocal
                managedRecipe?.vegans = NSNumber(bool: recipe.vegans!)
                managedRecipe?.vegetarians = NSNumber(bool: recipe.vegetarians!)
                managedRecipe?.suitableForVegans = NSNumber(bool: recipe.suitableForVegans!)
                managedRecipe?.raiting = NSNumber(integer: recipe.raiting!)
                var managedRecipes = managedLocal?.recipeRelationship?.allObjects
                managedRecipes?.append(managedRecipe!)
                managedLocal?.recipeRelationship = NSSet(array: managedRecipes!)
            }
        }
        dataStore?.saveContext()
        
        if completion != nil {
            completion!()
        }
    }
}
