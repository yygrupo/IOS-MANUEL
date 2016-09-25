//
//  WSearchPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WSearchPresenter: NSObject, WSearchModuleInterface
{
    var interactor: WSearchInteractor?
    weak var wireframe: WSearchWireframe?
    var userInterface: WSearchViewInterface?
    
    func updateViewWithCategories(categories: [WCategory]) {
        userInterface?.updateViewWithCategories(categories)
    }

    // MARK: - WSearchModuleInterface methods
    // implement module interface here
    
    func updateView() {
        interactor?.findCategories()
    }
    
    func doSearchWithCriteria(searchCriteria: WSearchCriteria) {
        WMainBoard.sharedInstance.searchCriteria = searchCriteria
        wireframe?.presentSearchResultViewController()
    }
}
