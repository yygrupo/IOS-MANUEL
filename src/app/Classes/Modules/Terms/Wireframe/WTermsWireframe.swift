//
//  WTermsWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation
import UIKit

class WTermsWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WTermsPresenter?
    var viewController: WTermsViewController?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WTermsViewController") as? WTermsViewController
        
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
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WTermsViewController") as? WTermsViewController
        navigationController?.viewControllers = [self.viewController!]
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(navigationController!)
    }
}
