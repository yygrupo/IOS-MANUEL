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

    // MARK: - WRegisterModuleInterface methods
    // implement module interface here
}
