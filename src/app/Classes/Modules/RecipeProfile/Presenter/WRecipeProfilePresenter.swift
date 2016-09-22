//
//  WRecipeProfilePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WRecipeProfilePresenter: NSObject, WRecipeProfileModuleInterface
{
    var interactor: WRecipeProfileInteractor?
    weak var wireframe: WRecipeProfileWireframe?
    var userInterface: WRecipeProfileViewInterface?

    // MARK: - WRecipeProfileModuleInterface methods
    // implement module interface here
}
