//
//  WSearchResultModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

protocol WSearchResultModuleInterface
{
    func updateView()
    func presentRecipeDetail(recipe: WRecipe)
    func findRecipesWithCategory(categoryId: String)
}

protocol WSearchResultModuleDelegate
{

}
