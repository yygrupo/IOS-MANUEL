//
//  WSearchDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WSearchDataManager: NSObject
{
    var dataStore: WCoreDataStore?
    
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
