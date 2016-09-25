//
//  WRecipeRatedPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 23/09/16.
//
//

import Foundation

class WRecipeRatedPresenter: NSObject, WRecipeRatedModuleInterface
{
    var interactor: WRecipeRatedInteractor?
    weak var wireframe: WRecipeRatedWireframe?
    var userInterface: WRecipeRatedViewInterface?
    
    func updateViewWithRecipes(recipes: [WRecipe]) {
        userInterface?.updateViewWithRecipes(recipes)
    }

    // MARK: - WRecipeRatedModuleInterface methods
    // implement module interface here
    func updateView() {
        interactor?.findRecipesRated()
    }
    
    func presentRecipeDetail(recipe: WRecipe) {
        WMainBoard.sharedInstance.recipeProfile = recipe
        wireframe?.presentRecipeProfileView()
    }
}
