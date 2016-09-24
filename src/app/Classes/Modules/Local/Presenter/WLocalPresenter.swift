//
//  WLocalPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WLocalPresenter: NSObject, WLocalModuleInterface
{
    var interactor: WLocalInteractor?
    weak var wireframe: WLocalWireframe?
    var userInterface: WLocalViewInterface?
    
    func updateViewWithLocal(locals: [WLocal]) {
        userInterface?.updateViewWithLocal(locals)
    }

    // MARK: - WLocalModuleInterface methods
    // implement module interface here
    
    func updateView() {
        interactor?.findLocals()
    }
}
