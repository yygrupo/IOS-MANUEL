//
//  WTermsPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation

class WTermsPresenter: NSObject, WTermsModuleInterface
{
    var interactor: WTermsInteractor?
    weak var wireframe: WTermsWireframe?
    var userInterface: WTermsViewInterface?

    // MARK: - WTermsModuleInterface methods
    // implement module interface here
}
