//
//  WRecipeProfileView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

protocol WRecipeProfileViewInterface
{
    func updateViewWithRecipe(recipe: WRecipe)
    func stopLoadingView()
}
