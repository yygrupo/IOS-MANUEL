//
//  WSearchResultWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import Foundation
import UIKit

class WSearchResultWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WSearchResultPresenter?
    var viewController: WSearchResultViewController?
    var recipeprofileWireframe: WRecipeProfileWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WSearchResultViewController") as? WSearchResultViewController
        
        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter
        
        // present controller
        // *** present self with RootViewController
        viewController.navigationController?.pushViewController(self.viewController!, animated: true)
    }
    
    func presentRecipeProfileView() {
        recipeprofileWireframe?.presentSelfFromViewController(self.viewController!)
    }
}
