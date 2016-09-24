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
    
    func findRecipesRated() {
        let locals = WMainBoard.sharedInstance.locals
        var recipes = [WRecipe]()
        
        for local in locals {
            for recipe in local.recipes! {
                if recipe.raiting > 0 {
                    recipes.append(recipe)
                }
            }
        }
        
        presenter?.updateViewWithRecipes(recipes)
    }
}
