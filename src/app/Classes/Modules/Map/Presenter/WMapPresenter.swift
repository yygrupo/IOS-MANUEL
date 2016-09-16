//
//  WMapPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

class WMapPresenter: NSObject, WMapModuleInterface
{
    var interactor: WMapInteractor?
    weak var wireframe: WMapWireframe?
    var userInterface: WMapViewInterface?

    // MARK: - WMapModuleInterface methods
    // implement module interface here
}
