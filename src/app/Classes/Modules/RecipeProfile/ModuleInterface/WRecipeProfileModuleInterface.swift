//
//  WRecipeProfileModuleInterface.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

protocol WRecipeProfileModuleInterface
{
    func updateView()
    func updateRate(recipe: WRecipe)
    func showLocalProfile(local: WLocal, recipe: WRecipe)
}

protocol WRecipeProfileModuleDelegate
{

}
