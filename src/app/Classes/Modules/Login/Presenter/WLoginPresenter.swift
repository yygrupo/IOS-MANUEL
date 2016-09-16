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

    // MARK: - WLoginModuleInterface methods
    // implement module interface here
}
