//
//  WSearchResultPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

class WSearchResultPresenter: NSObject, WSearchResultModuleInterface
{
    var interactor: WSearchResultInteractor?
    weak var wireframe: WSearchResultWireframe?
    var userInterface: WSearchResultViewInterface?

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
