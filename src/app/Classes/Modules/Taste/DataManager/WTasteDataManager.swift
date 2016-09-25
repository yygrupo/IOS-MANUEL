//
//  WTasteDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

class WTasteDataManager: NSObject
{
    var dataStore: WCoreDataStore?
    
    func findRecipesWithCategory(categoryId: String, completion:((recipes: [WRecipe]?) -> Void)?) {
        let predicate = NSPredicate(format: "(categoryid = %@) AND (tasted = %@) AND (favorite = %@)", categoryId, false, true)
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
        let predicate = NSPredicate(format: "(tasted = %@) AND (favorite = %@)", false, true)
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
}
