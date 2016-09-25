//
//  WTasteView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

protocol WTasteViewInterface
{
    func updateViewWithRecipes(recipes: [WRecipe])
    func updateViewWithCategories(categories: [WCategory])
    func stopLoadingView()
}
