//
//  WMenuPresenter.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

class WMenuPresenter: NSObject, WMenuModuleInterface
{
    var interactor: WMenuInteractor?
    weak var wireframe: WMenuWireframe?
    var userInterface: WMenuViewInterface?

    // MARK: - WMenuModuleInterface methods
    // implement module interface here
    
    func presentViewControllerAtIndex(index: Int) {
        switch index {
        case 0:
            wireframe?.presentHomeViewController()
            break
        case 1:
            wireframe?.presentLocalViewController()
            break
        case 2:
            wireframe?.presentRateViewController()
            break
        case 3:
            wireframe?.presentRecipesRateViewController()
            break
        case 4:
            // Same that home
            break
        case 5:
            wireframe?.presentMapViewController()
            break
        case 6:
            wireframe?.presentSearchViewController()
            break
        case 7:
            wireframe?.presentLoginViewController()
            break
        case 8:
            break
        case 9:
            break
        case 10:
            break
        default:
            break
        }
    }
}
