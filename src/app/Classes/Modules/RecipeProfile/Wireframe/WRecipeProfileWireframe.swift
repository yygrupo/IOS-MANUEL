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

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = WRecipeProfileViewController(nibName: "WRecipeProfileViewController", bundle: nil)

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
    }
}
