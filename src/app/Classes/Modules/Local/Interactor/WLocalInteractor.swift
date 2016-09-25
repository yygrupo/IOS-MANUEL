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
    
    var recipeStack = [WRecipe]()
    var recipesToShow = [WRecipe]()
    
    func findLocalsWithCategory(category: String) {
        dataManager?.findRecipesWithCategory(category, completion: { (recipes) in
            self.recipeStack = recipes!
            self.localStack.removeAll()
            self.currentLocals.removeAll()
            self.findLocalFromRecipe()
        })
    }
    
    func findLocalFromRecipe() {
        if recipeStack.count == 0 {
            for local in currentLocals {
                var currentLocal = local
                currentLocal.recipes = [WRecipe]()
                for recipe in recipesToShow {
                    if recipe.local?.id == local.id {
                        currentLocal.recipes?.append(recipe)
                    }
                }
                localStack.append(currentLocal)
            }
            currentLocals.removeAll()
            presenter?.updateViewWithLocal(localStack)
            WMainBoard.sharedInstance.locals = localStack
            recipesToShow.removeAll()
            recipeStack.removeAll()
            return
        }
        
        var recipe = recipeStack.removeFirst()
        dataManager?.findLocalFromRecipe(recipe, completion: { (local) in
            recipe.local = local
            self.recipesToShow.append(recipe)
            self.currentLocals.append(local!)
            self.findLocalFromRecipe()
        })
    }
    
    func findLocals() {
        dataManager?.findCategories({ (categories) in
            WMainBoard.sharedInstance.categories = categories!
            self.presenter?.updateViewWithCategories(categories!)
        })
        
        dataManager?.findLocals({ (locals) in
            self.localStack = locals!
            self.findRecipesFromLocal()
        })
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
