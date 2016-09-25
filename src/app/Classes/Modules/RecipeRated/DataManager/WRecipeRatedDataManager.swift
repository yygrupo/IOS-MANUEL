//
//  WRecipeRatedDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 23/09/16.
//
//

import Foundation

class WRecipeRatedDataManager: NSObject
{
    var dataStore: WCoreDataStore?
    
    func findRecipes(completion:((recipes: [WRecipe]?) -> Void)?) {
        let predicate = NSPredicate(format: "rating > %d", 0)
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
}
