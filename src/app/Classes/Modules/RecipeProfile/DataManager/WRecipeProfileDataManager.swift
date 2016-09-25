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
    
    func updateRateForRecipe(recipe: WRecipe, completion:(() -> Void)?) {
        let predicate = NSPredicate(format: "recipeid = %@", recipe.id!)
        let sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
        dataStore?.fetchEntriesForEntityName("Recipe", predicate: predicate, sortDescriptors: [sortDescriptor], completion: { (results) in
            if results.count > 0 {
                let managedEntity = results[0] as! NSManagedRecipe
                managedEntity.rating = NSNumber(integer: recipe.rating!)
            }
            self.dataStore?.saveContext()
            if completion != nil {
                completion!()
            }
        })
    }
}
