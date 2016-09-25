//
//  WLocalProfilePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WLocalProfilePresenter: NSObject, WLocalProfileModuleInterface
{
    var interactor: WLocalProfileInteractor?
    weak var wireframe: WLocalProfileWireframe?
    var userInterface: WLocalProfileViewInterface?
    
    func updateViewWithLocal(local: WLocal) {
        let recipe = WMainBoard.sharedInstance.recipeProfile
        userInterface?.updateViewWithLocal(local, recipe: recipe)
    }

    // MARK: - WLocalProfileModuleInterface methods
    // implement module interface here
    
    func updateView() {
        interactor?.findLocal()
    }
}
