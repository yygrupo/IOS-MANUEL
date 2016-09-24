//
//  WRecipeRatedWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 23/09/16.
//
//

import Foundation
import UIKit

class WRecipeRatedWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WRecipeRatedPresenter?
    var viewController: WRecipeRatedViewController?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = WRecipeRatedViewController(nibName: "WRecipeRatedViewController", bundle: nil)

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
    }
    
    func presentSelfViewController()
    {
        // save reference
        let navigationController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("firstNavigationController") as? UINavigationController
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WRecipeRatedViewController") as? WRecipeRatedViewController
        navigationController?.viewControllers = [self.viewController!]
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(navigationController!)
    }
}
