//
//  WHomePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WHomePresenter: NSObject, WHomeModuleInterface
{
    var interactor: WHomeInteractor?
    weak var wireframe: WHomeWireframe?
    var userInterface: WHomeViewInterface?

    // MARK: - WHomeModuleInterface methods
    // implement module interface here
}
