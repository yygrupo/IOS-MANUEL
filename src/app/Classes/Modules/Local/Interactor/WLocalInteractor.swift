//
//  WLocalInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WLocalInteractor: NSObject
{
    weak var presenter: WLocalPresenter?
    var dataManager: WLocalDataManager?
    
    func findLocals() {
        let locals = WMainBoard.sharedInstance.locals
        presenter?.updateViewWithLocal(locals)
    }
}
