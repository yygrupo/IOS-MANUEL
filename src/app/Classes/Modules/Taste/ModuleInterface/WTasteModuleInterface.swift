//
//  WTasteModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

protocol WTasteModuleInterface
{
    func updateView()
    func presentRecipeDetail(recipe: WRecipe)
    func findRecipesWithCategory(categoryId: String)
}

protocol WTasteModuleDelegate
{

}
