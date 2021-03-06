//
//  WRecipeProfileInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WRecipeProfileInteractor: NSObject
{
    weak var presenter: WRecipeProfilePresenter?
    var dataManager: WRecipeProfileDataManager?
    
    func updateRecipe(recipe: WRecipe) {
        dataManager?.updateRecipe(recipe, completion: { 
            self.presenter?.recipeUpdate()
        })
    }
}
