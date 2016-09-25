//
//  WStartPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

class WStartPresenter: NSObject, WStartModuleInterface
{
    var interactor: WStartInteractor?
    weak var wireframe: WStartWireframe?
    var userInterface: WStartViewInterface?

    // MARK: - WStartModuleInterface methods
    // implement module interface here
    
    func animationDone() {
        wireframe?.presentHomeViewController()
    }
}
