//
//  WLocalInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WLocalInteractor: NSObject
{
    weak var presenter: WLocalPresenter?
    var dataManager: WLocalDataManager?
    var currentLocals = [WLocal]()
    var localStack = [WLocal]()
    
    func findLocals() {
        let locals = WMainBoard.sharedInstance.locals
        if locals.count > 0 {
            presenter?.updateViewWithLocal(locals)
        } else {
            dataManager?.findLocals({ (locals) in
                self.localStack = locals!
                self.findRecipesFromLocal()
            })
        }
    }
    
    func findRecipesFromLocal() {
        if localStack.count == 0 {
            WMainBoard.sharedInstance.locals = currentLocals
            self.presenter?.updateViewWithLocal(currentLocals)
            return
        }
        var local = localStack.removeFirst()
        dataManager?.findRecipesFromLocal(local, completion: { (recipes) in
            local.recipes = recipes
            self.currentLocals.append(local)
            self.findRecipesFromLocal()
        })
    }
}
