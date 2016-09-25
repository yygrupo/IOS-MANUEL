//
//  WMapPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

class WMapPresenter: NSObject, WMapModuleInterface
{
    var interactor: WMapInteractor?
    weak var wireframe: WMapWireframe?
    var userInterface: WMapViewInterface?

    func updateViewWithLocal(locals: [WLocal]) {
        userInterface?.updateViewWithLocal(locals)
    }
    
    // MARK: - WLocalModuleInterface methods
    // implement module interface here
    
    func updateView() {
        interactor?.findLocals()
    }
    
    func showLocalProfile(local: WLocal) {
        WMainBoard.sharedInstance.recipeProfile = nil
        WMainBoard.sharedInstance.localProfile = local
        wireframe?.presentLocalDetailView()
    }
}
