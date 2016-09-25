//
//  WRecipeRatedInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 23/09/16.
//
//

import Foundation

class WRecipeRatedInteractor: NSObject
{
    weak var presenter: WRecipeRatedPresenter?
    var dataManager: WRecipeRatedDataManager?
    
    var recipeStack = [WRecipe]()
    var recipesToShow = [WRecipe]()
    
    func findRecipesRated() {
        recipeStack.removeAll()
        recipesToShow.removeAll()
        dataManager?.findRecipes({ (recipes) in
            self.recipeStack = recipes!
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
            self.findLocalFromRecipe()
        })
    }
}
