//
//  WLocalWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation
import UIKit

class WLocalWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WLocalPresenter?
    var viewController: WLocalViewController?
    var localprofileWireframe: WLocalProfileWireframe?
    var mapWireframe: WMapWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WLocalViewController") as? WLocalViewController

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
        viewController.navigationController?.pushViewController(self.viewController!, animated: true)
    }
    
    func getSelfViewController() -> UIViewController {
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WLocalViewController") as? WLocalViewController
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        return self.viewController!
    }
    
    func presentSelfViewController()
    {
        // save reference
        let navigationController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("firstNavigationController") as? UINavigationController
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WLocalViewController") as? WLocalViewController
        navigationController?.viewControllers = [self.viewController!]
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        rootWireframe?.setMainViewController(navigationController!)
    }
    
    func presentLocalDetailView() {
        localprofileWireframe?.presentSelfFromViewController(self.viewController!)
    }
    
    func presentMapViewController() {
        mapWireframe?.presentSelfFromViewController(self.viewController!)
    }
}
