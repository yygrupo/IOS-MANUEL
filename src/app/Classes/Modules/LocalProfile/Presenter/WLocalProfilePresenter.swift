//
//  WLocalProfilePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation

class WLocalProfilePresenter: NSObject, WLocalProfileModuleInterface
{
    var interactor: WLocalProfileInteractor?
    weak var wireframe: WLocalProfileWireframe?
    var userInterface: WLocalProfileViewInterface?

    // MARK: - WLocalProfileModuleInterface methods
    // implement module interface here
}
