//
//  WLocalProfileDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WLocalProfileDataManager: NSObject
{
    var dataStore: WCoreDataStore?
    
    func findRecipesFromLocal(local: WLocal, completion: ((recipes: [WRecipe]) -> Void)?) {        
        let predicate = NSPredicate(format: "localid = %@", local.id!)
        dataStore?.fetchEntriesForEntityName("Recipe", predicate: predicate, sortDescriptors: [], completion: { (results) in
            var recipes = [WRecipe]()
            if results.count > 0 {
                for entity in results {
                    let managedRecipe = entity as! NSManagedRecipe
                    recipes.append(Utils.recipeFromManagedEntity(managedRecipe))
                }
            }
            if completion != nil {
                completion!(recipes: recipes)
            }
        })
    }
}
