//
//  WHomePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WHomePresenter: NSObject, WHomeModuleInterface
{
    var interactor: WHomeInteractor?
    weak var wireframe: WHomeWireframe?
    var userInterface: WHomeViewInterface?
    
    func updateViewWithRecipes(recipes: [WRecipe]) {
        userInterface?.updateViewWithRecipes(recipes)
    }
    
    func updateViewWithCategories(categories: [WCategory]) {
        userInterface?.updateViewWithCategories(categories)
    }
    
    // MARK: - WHomeModuleInterface methods
    // implement module interface here
    
    func updateView() {
        interactor?.findRecipes()
    }
    
    func presentRecipeDetail(recipe: WRecipe) {
        WMainBoard.sharedInstance.recipeProfile = recipe
        wireframe?.presentRecipeProfileView()
    }
    
    func findRecipesWithCategory(categoryId: String) {
        interactor?.findRecipesWithCategory(categoryId)
    }
}
