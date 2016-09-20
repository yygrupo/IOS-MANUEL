//
//  WLocalProfileWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import Foundation
import UIKit

class WLocalProfileWireframe: NSObject
{
    var rootWireframe: RootWireframe?
    var presenter: WLocalProfilePresenter?
    var viewController: WLocalProfileViewController?

    func presentSelfFromViewController(viewController: UIViewController)
    {
        // save reference
        self.viewController = WLocalProfileViewController(nibName: "WLocalProfileViewController", bundle: nil)

        // view <-> presenter
        self.presenter?.userInterface = self.viewController
        self.viewController?.eventHandler = self.presenter

        // present controller
        // *** present self with RootViewController
    }
}
