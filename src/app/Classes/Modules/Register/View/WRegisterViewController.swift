//
//  WRegisterViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import UIKit

class WRegisterViewController: UIViewController, WRegisterViewInterface
{
    var eventHandler: WRegisterModuleInterface?

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
    }
    
    // MARK: - Private
    private func setupView() {
        let titleLabel = UILabel(frame: (self.navigationController?.navigationBar.frame)!)
        titleLabel.textAlignment = .Left
        titleLabel.text = "Rexistro".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WRegisterViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
    }

    // MARK: - WRegisterViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here

    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
}
