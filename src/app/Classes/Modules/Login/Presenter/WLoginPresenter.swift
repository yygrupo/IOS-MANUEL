//
//  WLoginPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

class WLoginPresenter: NSObject, WLoginModuleInterface
{
    var interactor: WLoginInteractor?
    weak var wireframe: WLoginWireframe?
    var userInterface: WLoginViewInterface?
    
    func userNotFound() {
        userInterface?.userNotFound()
    }
    
    func wrongPassword() {
        userInterface?.wrongPassword()
    }
    
    func userFound() {
        userInterface?.stopLoadingView()
        wireframe?.presentUserProfileViewController()
    }

    // MARK: - WLoginModuleInterface methods
    // implement module interface here
    
    func doLogin(user: String, password: String) {
        interactor?.doLogin(user, password: password)
    }
    
    func showRegisterForm() {
        wireframe?.presentRegisterViewController()
    }
}
