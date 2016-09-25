//
//  WLoginViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import UIKit
import BRYXBanner
import FlatUIColors
import MBProgressHUD

class WLoginViewController: UIViewController, WLoginViewInterface
{
    @IBOutlet weak var buttonLogin: UIButton?
    
    @IBOutlet weak var viewLoginContainer: UIView!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var loadingView: MBProgressHUD?
    
    var eventHandler: WLoginModuleInterface?

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
        titleLabel.text = "Acceso".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WLoginViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        buttonLogin?.clipsToBounds = true
        buttonLogin?.layer.cornerRadius = 8.0
        
        viewLoginContainer.setupViewForApp()
    }
    
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }

    // MARK: - WLoginViewInterface methods

    // *** implement view_interface methods here
    
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func userNotFound() {
        let image: UIImage = UIImage(named: "User")!
        let banner = Banner(title: "Error".localized, subtitle: "Usuario no encontrado".localized, image: image, backgroundColor: FlatUIColors.carrotColor())
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
    }
    
    func wrongPassword() {
        let image: UIImage = UIImage(named: "User")!
        let banner = Banner(title: "Error".localized, subtitle: "Contrasinal incorrecta".localized, image: image, backgroundColor: FlatUIColors.carrotColor())
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
    }

    // MARK: - Button event handlers

    // ** handle UI events here

    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func doLogin() {
        if textFieldUsername.text?.isEmpty == true {
            let image: UIImage = UIImage(named: "User")!
            let banner = Banner(title: "Error".localized, subtitle: "Usuario vacío".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        if textFieldPassword.text?.isEmpty == true {
            let image: UIImage = UIImage(named: "password")!
            let banner = Banner(title: "Error".localized, subtitle: "Usuario vacío".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.doLogin(self.textFieldUsername.text!, password: self.textFieldPassword.text!)
        })
    }
    
    @IBAction func goToRegister() {
        eventHandler?.showRegisterForm()
    }
}
