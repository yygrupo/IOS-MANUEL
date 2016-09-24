//
//  WRecipeRatedView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 23/09/16.
//
//

import Foundation

protocol WRecipeRatedViewInterface
{
    func updateViewWithRecipes(recipes: [WRecipe])
    func stopLoadingView()
}
