//
//  WSearchWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation
import UIKit

class WSearchWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WSearchPresenter?
    var viewController: WSearchViewController?
    var searchresultWireframe: WSearchResultWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WSearchViewController") as? WSearchViewController

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
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WSearchViewController") as? WSearchViewController
        navigationController?.viewControllers = [self.viewController!]
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(navigationController!)
    }
    
    func presentSearchResultViewController() {
        searchresultWireframe!.presentSelfFromViewController(self.viewController!)
    }
}
