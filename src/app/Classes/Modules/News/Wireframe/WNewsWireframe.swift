//
//  WNewsWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation
import UIKit

class WNewsWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WNewsPresenter?
    var viewController: WNewsViewController?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WNewsViewController") as? WNewsViewController

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
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WNewsViewController") as? WNewsViewController
        navigationController?.viewControllers = [self.viewController!]
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(navigationController!)
    }
}
