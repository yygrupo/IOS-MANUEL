//
//  WProfilePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

class WProfilePresenter: NSObject, WProfileModuleInterface
{
    var interactor: WProfileInteractor?
    weak var wireframe: WProfileWireframe?
    var userInterface: WProfileViewInterface?
    
    func updateViewWithUser(user: WUser) {
        userInterface?.updateViewWithUser(user)
    }
    
    func logOutDone() {
        userInterface?.stopLoadingView()
        wireframe?.presentLoginViewController()
    }

    // MARK: - WProfileModuleInterface methods
    // implement module interface here
    
    func updateView() {
        interactor?.findUser()
    }
    
    func updateUser(user: WUser) {
        interactor?.updateUser(user)
    }
    
    func logOut() {
        interactor?.logOut()
    }
}
