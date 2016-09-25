//
//  RootWireframe.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation
import UIKit

class RootWireframe: NSObject
{
    var window: UIWindow?
    var menuWireframe: WMenuWireframe?
    var slideMenuController: WSlideMenuViewController?
    
    init(window: UIWindow)
    {
        super.init()
        // custom initialization
        self.window = window
    }
    
    func storyBoard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
    
    func showStartViewController(viewController: UIViewController) {
        self.window?.backgroundColor = UIColor(hexString: "#1A4682")
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
    
    func showRootViewController(viewController: UIViewController) {
        slideMenuController = WSlideMenuViewController(mainViewController: viewController, leftMenuViewController: (menuWireframe?.selfViewController())!)
        slideMenuController!.automaticallyAdjustsScrollViewInsets = true
        self.window?.backgroundColor = UIColor(hexString: "#1A4682")
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func setMainViewController(viewController: UIViewController) {
        slideMenuController?.mainViewController = viewController
        slideMenuController?.closeLeft()
        slideMenuController!.view.setNeedsDisplay()
    }
    
    func selfNavigationController() -> UINavigationController {
        let navigationController = window!.rootViewController as! UINavigationController
        return navigationController
    }
}
