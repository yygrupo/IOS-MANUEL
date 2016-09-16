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
        var categories: [WCategory] = []
        for recipe in recipes {
            let category = WCategory(cid: recipe.cid, category_name: recipe.category_name, category_image: recipe.category_image)
            if categories.contains(category) == false {
                categories.append(category)
            }
        }
        userInterface?.updateViewWithCategories(categories)
        userInterface?.updateViewWithRecipes(recipes)
    }
    
    // MARK: - WHomeModuleInterface methods
    // implement module interface here
    
    func updateView() {
        interactor?.findRecipes()
    }
}
