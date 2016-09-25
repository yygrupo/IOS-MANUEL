//
//  WNewsPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

class WNewsPresenter: NSObject, WNewsModuleInterface
{
    var interactor: WNewsInteractor?
    weak var wireframe: WNewsWireframe?
    var userInterface: WNewsViewInterface?

    // MARK: - WNewsModuleInterface methods
    // implement module interface here
}
