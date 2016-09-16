//
//  WRateViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit

class WRateViewController: UIViewController, WRateViewInterface
{
    @IBOutlet weak var containerView: UIView?
    
    var eventHandler: WRateModuleInterface?

    // MARK: - View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
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
        titleLabel.text = "Puntuar".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WRateViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        containerView?.setupViewForApp()
    }

    // MARK: - WRateViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
}