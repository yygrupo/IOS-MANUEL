//
//  WSearchResultInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation
import CoreLocation

class WSearchResultInteractor: NSObject
{
    weak var presenter: WSearchResultPresenter?
    var dataManager: WSearchResultDataManager?
    
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
        let searchCriteria = WMainBoard.sharedInstance.searchCriteria
        
        dataManager?.findRecipesWithCriteria(searchCriteria!, completion: { (recipes) in
            self.recipeStack = recipes!
            WMainBoard.sharedInstance.locals = [WLocal]()
            self.findLocalFromRecipe()
        })
    }
    
    func findLocalFromRecipe() {
        if recipeStack.count == 0 {
            let searchCriteria = WMainBoard.sharedInstance.searchCriteria
            if searchCriteria?.radio > 0 {
                let currentLocation = WMainBoard.sharedInstance.currentLocation
                var tempRecipes = [WRecipe]()
                for recipe in recipesToShow {
                    let location0 = CLLocation(latitude: (recipe.local?.latitude)!, longitude: (recipe.local?.longitude)!)
                    let distance = (currentLocation?.distanceFromLocation(location0))! / 1000
                    if distance <= searchCriteria?.radio?.toDouble {
                        tempRecipes.append(recipe)
                    }
                }
                recipesToShow = tempRecipes
            }
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
