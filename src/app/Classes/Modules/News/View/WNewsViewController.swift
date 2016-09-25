//
//  WNewsViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import UIKit

class WNewsViewController: UIViewController, WNewsViewInterface
{
    var eventHandler: WNewsModuleInterface?

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
        titleLabel.text = "Novas".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WNewsViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
    }
    
    // MARK: - WTermsViewInterface methods
    
    // *** implement view_interface methods here
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
}
