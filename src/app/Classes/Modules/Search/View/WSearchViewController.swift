//
//  WSearchViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit

class WSearchViewController: UIViewController, WSearchViewInterface
{
    @IBOutlet weak var nameViewContainer: UIView?
    @IBOutlet weak var radioViewContainer: UIView?
    @IBOutlet weak var categoryViewContainer: UIView?
    @IBOutlet weak var optionsViewContainer:UIView?
    
    @IBOutlet weak var buttonSearch: UIButton?
    
    var eventHandler: WSearchModuleInterface?

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
        titleLabel.text = "Buscar".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WSearchViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        nameViewContainer?.setupViewForApp()
        radioViewContainer?.setupViewForApp()
        categoryViewContainer?.setupViewForApp()
        optionsViewContainer?.setupViewForApp()
        
        buttonSearch?.clipsToBounds = true
        buttonSearch?.layer.cornerRadius = 8.0
    }

    // MARK: - WSearchViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here

    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
}
