//
//  WRecipeProfilePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WRecipeProfilePresenter: NSObject, WRecipeProfileModuleInterface
{
    var interactor: WRecipeProfileInteractor?
    weak var wireframe: WRecipeProfileWireframe?
    var userInterface: WRecipeProfileViewInterface?
    
    func recipeUpdate() {
        userInterface?.stopLoadingView()
    }

    // MARK: - WRecipeProfileModuleInterface methods
    // implement module interface here
    
    func updateView() {
        let recipe = WMainBoard.sharedInstance.recipeProfile
        userInterface?.updateViewWithRecipe(recipe!)
    }
    
    func updateRecipe(recipe: WRecipe) {
        interactor?.updateRecipe(recipe)
    }
    
    func showLocalProfile(local: WLocal, recipe: WRecipe) {
        WMainBoard.sharedInstance.recipeProfile = recipe
        WMainBoard.sharedInstance.localProfile = local
        wireframe?.presentLocalDetailView()
    }
}
