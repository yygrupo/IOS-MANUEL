//
//  WLocalProfileInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WLocalProfileInteractor: NSObject
{
    weak var presenter: WLocalProfilePresenter?
    var dataManager: WLocalProfileDataManager?
    
    func findLocal() {
        var local = WMainBoard.sharedInstance.localProfile
        dataManager?.findRecipesFromLocal(local!, completion: { (recipes) in
            local?.recipes = recipes
            self.presenter?.updateViewWithLocal(local!)
        })
    }
}
