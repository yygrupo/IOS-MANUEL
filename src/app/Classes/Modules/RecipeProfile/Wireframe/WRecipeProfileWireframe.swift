//
//  WRecipeProfileWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation
import UIKit

class WRecipeProfileWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WRecipeProfilePresenter?
    var viewController: WRecipeProfileViewController?
    var localprofileWireframe: WLocalProfileWireframe?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = self.rootWireframe!.storyBoard().instantiateViewControllerWithIdentifier("WRecipeProfileViewController") as? WRecipeProfileViewController

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
        viewController.navigationController?.pushViewController(self.viewController!, animated: true)
    }
    
    func presentLocalDetailView() {
        localprofileWireframe?.presentSelfFromViewController(self.viewController!)
    }
}
