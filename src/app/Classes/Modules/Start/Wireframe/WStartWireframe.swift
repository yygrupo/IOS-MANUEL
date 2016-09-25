//
//  WStartWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation
import UIKit

class WStartWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WStartPresenter?
    var viewController: WStartViewController?
    var homeWireframe: WHomeWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WStartViewController") as? WStartViewController

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
    }
    
    func presentSelfViewControllerAsRootViewController()
    {
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WStartViewController") as? WStartViewController
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        self.rootWireframe?.showStartViewController(self.viewController!)
    }
    
    func presentHomeViewController() {
        homeWireframe?.presentSelfViewControllerAsRootViewController()
    }
}
