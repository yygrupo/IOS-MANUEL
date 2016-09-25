//
//  WStartViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import UIKit

class WStartViewController: UIViewController, WStartViewInterface
{
    @IBOutlet weak var imageViewHorizontalLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var imageViewVerticalLayoutConstraint: NSLayoutConstraint?
    
    var eventHandler: WStartModuleInterface?

    // MARK: - View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        animatedImageView()
    }
    
    // MARK: - Private
    func animatedImageView() {
        imageViewHorizontalLayoutConstraint?.constant = -30
        imageViewVerticalLayoutConstraint?.constant = 30
        UIView.animateWithDuration(3.0, animations: { 
            self.view.layoutIfNeeded()
            }) { (value) in
            self.eventHandler?.animationDone()
        }
    }

    // MARK: - WStartViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here

}
