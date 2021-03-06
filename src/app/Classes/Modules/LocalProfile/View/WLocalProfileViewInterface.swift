//
//  WLocalProfileView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

protocol WLocalProfileViewInterface
{
    func updateViewWithLocal(local: WLocal, recipe: WRecipe?)
    func stopLoadingView()
}
