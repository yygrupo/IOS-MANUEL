//
//  WRecipeProfileDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WRecipeProfileDataManager: NSObject
{
    var dataStore: WCoreDataStore?
    
    func updateRecipe(recipe: WRecipe, completion:(() -> Void)?) {
        let predicate = NSPredicate(format: "recipeid = %@", recipe.id!)
        dataStore?.fetchEntriesForEntityName("Recipe", predicate: predicate, sortDescriptors: [], completion: { (results) in
            if results.count > 0 {
                let managedEntity = results[0] as! NSManagedRecipe
                managedEntity.rating = NSNumber(integer: recipe.rating!)
                managedEntity.favorite = NSNumber(bool: recipe.favorite!)
                managedEntity.tasted = NSNumber(bool: recipe.tasted!)
            }
            self.dataStore?.saveContext()
            if completion != nil {
                completion!()
            }
        })
    }
}
