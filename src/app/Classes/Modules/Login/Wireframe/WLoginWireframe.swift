//
//  WLoginWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation
import UIKit

class WLoginWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WLoginPresenter?
    var viewController: WLoginViewController?
    var profileWireframe: WProfileWireframe?
    var registerWireframe: WRegisterWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WLoginViewController") as? WLoginViewController

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
        viewController.navigationController?.pushViewController(self.viewController!, animated: true)
    }
    
    func presentSelfViewController()
    {
        // save reference
        let navigationController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("firstNavigationController") as? UINavigationController
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WLoginViewController") as? WLoginViewController
        navigationController?.viewControllers = [self.viewController!]
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(navigationController!)
    }
    
    func presentUserProfileViewController() {
        profileWireframe?.presentSelfFromViewController(self.viewController!)
    }
    
    func presentRegisterViewController() {
        registerWireframe?.presentSelfFromViewController(self.viewController!)
    }
}
