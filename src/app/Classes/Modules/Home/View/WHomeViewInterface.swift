//
//  WHomeView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

protocol WHomeViewInterface
{
    func updateViewWithRecipes(recipes: [WRecipe])
    func updateViewWithCategories(categories: [WCategory])
    func stopLoadingView()
}
