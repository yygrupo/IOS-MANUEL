//
//  WMenuWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation
import UIKit

class WMenuWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WMenuPresenter?
    var viewController: WMenuViewController?
    
    var homeWireframe: WHomeWireframe?
    var localWireframe: WLocalWireframe?
    var rateWireframe: WRateWireframe?
    var searchWireframe: WSearchWireframe?
    var loginWireframe: WLoginWireframe?
    var registerWireframe: WRegisterWireframe?
    var profileWireframe: WProfileWireframe?
    var mapWireframe: WMapWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = WMenuViewController(nibName: "WMenuViewController", bundle: nil)

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(self.viewController!)
    }
    
    func presentSelfViewController() {
        // save reference
        self.viewController = WMenuViewController(nibName: "WMenuViewController", bundle: nil)
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(self.viewController!)
    }
    
    func selfViewController() -> UIViewController {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WMenuViewController") as? WMenuViewController
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        return self.viewController!
    }
    
    func presentHomeViewController() {
        homeWireframe?.presentSelfViewController()
    }
    
    func presentLoginViewController() {
        loginWireframe?.presentSelfViewController()
    }
    
    func presentSearchViewController() {
        searchWireframe?.presentSelfViewController()
    }
    
    func presentRateViewController() {
        rateWireframe?.presentSelfViewController()
    }
    
    func presentRegisterViewController() {
        registerWireframe?.presentSelfViewController()
    }
    
    func presentProfileViewController() {
        profileWireframe?.presentSelfViewController()
    }
    
    func presentLocalViewController() {
        localWireframe?.presentSelfViewController()
    }
    
    func presentMapViewController() {
        mapWireframe?.presentSelfViewController()
    }
}
