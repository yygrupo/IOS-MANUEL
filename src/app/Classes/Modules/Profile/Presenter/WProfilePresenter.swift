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

    // MARK: - WProfileModuleInterface methods
    // implement module interface here
}
