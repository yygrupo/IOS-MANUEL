//
//  WTasteInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

class WTasteInteractor: NSObject
{
    weak var presenter: WTastePresenter?
    var dataManager: WTasteDataManager?
    var recipeStack = [WRecipe]()
    var recipesToShow = [WRecipe]()
    
    func findRecipesWithCategory(categoryId: String) {
        dataManager?.findRecipesWithCategory(categoryId, completion: { (recipes) in
            self.recipeStack = recipes!
            WMainBoard.sharedInstance.locals = [WLocal]()
            self.findLocalFromRecipe()
        })
    }
    
    func findRecipes() {
        dataManager?.findCategories({ (categories) in
            WMainBoard.sharedInstance.categories = categories!
            self.presenter?.updateViewWithCategories(categories!)
        })
        recipeStack.removeAll()
        recipesToShow.removeAll()
        dataManager?.findRecipes({ (recipes) in
            self.recipeStack = recipes!
            WMainBoard.sharedInstance.locals = [WLocal]()
            self.findLocalFromRecipe()
        })
    }
    
    func findLocalFromRecipe() {
        if recipeStack.count == 0 {
            self.presenter?.updateViewWithRecipes(recipesToShow)
            return
        }
        
        var recipe = recipeStack.removeFirst()
        dataManager?.findLocalFromRecipe(recipe, completion: { (local) in
            recipe.local = local
            self.recipesToShow.append(recipe)
            WMainBoard.sharedInstance.locals.append(local!)
            self.findLocalFromRecipe()
        })
    }
}
