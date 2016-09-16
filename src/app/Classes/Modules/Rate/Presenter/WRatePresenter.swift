//
//  WRatePresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WRatePresenter: NSObject, WRateModuleInterface
{
    var interactor: WRateInteractor?
    weak var wireframe: WRateWireframe?
    var userInterface: WRateViewInterface?

    // MARK: - WRateModuleInterface methods
    // implement module interface here
}
