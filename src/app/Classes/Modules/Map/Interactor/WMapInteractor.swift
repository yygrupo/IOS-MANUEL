//
//  WMapInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

class WMapInteractor: NSObject
{
    weak var presenter: WMapPresenter?
    var dataManager: WMapDataManager?
    
    func findLocals() {
        dataManager?.findLocals({ (locals) in
            WMainBoard.sharedInstance.locals = locals!
            self.presenter?.updateViewWithLocal(locals!)
        })
    }
}
