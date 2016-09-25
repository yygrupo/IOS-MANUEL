//
//  WHomeModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

protocol WHomeModuleInterface
{
    func updateView()
    func presentRecipeDetail(recipe: WRecipe)
    func findRecipesWithCategory(categoryId: String)
}

protocol WHomeModuleDelegate
{
    
}
