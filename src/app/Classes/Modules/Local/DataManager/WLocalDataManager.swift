//
//  WLocalDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WLocalDataManager: NSObject
{
    var dataStore: WCoreDataStore?
    
    func findLocals(completion:((locals: [WLocal]?) -> Void)?) {
        dataStore?.fetchEntriesForEntityName("Local", predicate: nil, sortDescriptors: [], completion: { (results) in
            var locals = [WLocal]()
            for entityObject in results {
                let managedObject = entityObject as? NSManagedLocal
                if managedObject == nil {
                    continue
                }
                let local = Utils.localFromManagedEntity(entityObject as! NSManagedLocal)
                locals.append(local)
            }
            if completion != nil {
                completion!(locals: locals)
            }
        })
    }
    
    func findRecipesFromLocal(local: WLocal, completion: ((recipes: [WRecipe]) -> Void)?) {
        var recipes = [WRecipe]()
        
        let predicate = NSPredicate(format: "localid = %@", local.id!)
        dataStore?.fetchEntriesForEntityName("Recipe", predicate: predicate, sortDescriptors: [], completion: { (results) in
            for managedObject in results {
                let managedLocal = managedObject as! NSManagedRecipe
                recipes.append(Utils.recipeFromManagedEntity(managedLocal))
            }
            if completion != nil {
                completion!(recipes: recipes)
            }
        })
    }
}
