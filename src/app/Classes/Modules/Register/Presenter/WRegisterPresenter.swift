//
//  WRegisterPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

class WRegisterPresenter: NSObject, WRegisterModuleInterface
{
    var interactor: WRegisterInteractor?
    weak var wireframe: WRegisterWireframe?
    var userInterface: WRegisterViewInterface?
    
    func userRegistered() {
        userInterface?.stopLoadingView()
        wireframe?.presentUserProfileView()
    }

    // MARK: - WRegisterModuleInterface methods
    // implement module interface here
    
    func registerUser(user: WUser) {
        interactor?.registerUser(user)
    }
}
