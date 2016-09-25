//
//  WTasteWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation
import UIKit

class WTasteWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WTastePresenter?
    var viewController: WTasteViewController?
    var recipeprofileWireframe: WRecipeProfileWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WTasteViewController") as? WTasteViewController
        
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
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WTasteViewController") as? WTasteViewController
        navigationController?.viewControllers = [self.viewController!]
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(navigationController!)
    }
    
    func presentRecipeProfileView() {
        recipeprofileWireframe?.presentSelfFromViewController(self.viewController!)
    }
}
