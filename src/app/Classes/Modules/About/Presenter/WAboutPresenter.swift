//
//  WAboutPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

class WAboutPresenter: NSObject, WAboutModuleInterface
{
    var interactor: WAboutInteractor?
    weak var wireframe: WAboutWireframe?
    var userInterface: WAboutViewInterface?

    // MARK: - WAboutModuleInterface methods
    // implement module interface here
}
