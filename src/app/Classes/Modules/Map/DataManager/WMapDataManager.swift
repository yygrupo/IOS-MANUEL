//
//  WMapDataManager.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

class WMapDataManager: NSObject
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
}
