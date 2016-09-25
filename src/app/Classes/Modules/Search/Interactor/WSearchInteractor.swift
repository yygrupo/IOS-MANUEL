//
//  WSearchInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WSearchInteractor: NSObject
{
    weak var presenter: WSearchPresenter?
    var dataManager: WSearchDataManager?
    
    func findCategories() {
        dataManager?.findCategories({ (categories) in
            self.presenter?.updateViewWithCategories(categories!)
        })
    }
    
    func doSearchWithCriteria(searchCriteria: WSearchCriteria) {
        
    }
}
