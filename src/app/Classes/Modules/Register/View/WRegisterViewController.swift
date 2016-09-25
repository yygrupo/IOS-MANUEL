//
//  WRegisterViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import UIKit
import BRYXBanner
import FlatUIColors
import MBProgressHUD
import MobileCoreServices

class WRegisterViewController: UIViewController, WRegisterViewInterface, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldRepeatPassword: UITextField!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    @IBOutlet weak var imageViewDummyBackground: UIImageView!
    
    var backgroundSelected = false
    var avatarSelected = false
    var currentImageSelection = 0
    var loadingView: MBProgressHUD?
    
    var eventHandler: WRegisterModuleInterface?
    
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
        titleLabel.text = "Rexistro".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WRegisterViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
    }
    
    func showImagePickerMenu() {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Seleccione".localized, message: "", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancelar".localized, style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Cámara".localized, style: .Default)
        { action -> Void in
            //Action
            self.showCamera()
        }
        actionSheetController.addAction(takePictureAction)
        
        
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Galería".localized, style: .Default)
        { action -> Void in
            //Action
            self.showGallery()
        }
        actionSheetController.addAction(choosePictureAction)
        
        if currentImageSelection == 0 {
            actionSheetController.popoverPresentationController?.sourceView = imageViewDummyBackground! as UIView
        } else {
            actionSheetController.popoverPresentationController?.sourceView = imageViewAvatar! as UIView
        }
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func showCamera() {
        let isCamera = UIImagePickerController.isSourceTypeAvailable(.Camera)
        if isCamera == false {
            let image: UIImage = UIImage(named: "Compact Camera")!
            let banner = Banner(title: "Información".localized, subtitle: "Cámara no disponible".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return;
        }
        
        backgroundSelected = false
        avatarSelected = false
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func showGallery() {
        let isGallery = UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
        if isGallery == false {
            let image: UIImage = UIImage(named: "Gallery Filled")!
            let banner = Banner(title: "Información".localized, subtitle: "Galería no disponible".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return;
        }
        
        backgroundSelected = false
        avatarSelected = false
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        if DeviceInfo.ISPHONE == true {
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            imagePicker.modalPresentationStyle = .Popover
            if currentImageSelection == 0 {
                imagePicker.popoverPresentationController?.sourceView = imageViewDummyBackground as UIView
                imagePicker.popoverPresentationController?.sourceRect = imageViewDummyBackground.frame
            } else {
                imagePicker.popoverPresentationController?.sourceView = imageViewAvatar as UIView
                imagePicker.popoverPresentationController?.sourceRect = imageViewAvatar.frame
            }
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePicker delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            if currentImageSelection == 0 {
                imageViewBackground.image = editedImage
            } else {
                imageViewAvatar.image = editedImage
            }
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if currentImageSelection == 0 {
                imageViewBackground.image = originalImage
            } else {
                imageViewAvatar.image = originalImage
            }
        }
        if currentImageSelection == 0 {
            backgroundSelected = true
            imageViewBackground.setNeedsDisplay()
            imageViewDummyBackground.hidden = true
        } else {
            avatarSelected = true
            imageViewAvatar.setNeedsDisplay()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }
    
    // MARK: - WRegisterViewInterface methods
    
    // *** implement view_interface methods here
    
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func selectBackgroundImage(sender: UIButton) {
        currentImageSelection = 0
        showImagePickerMenu()
    }
    
    @IBAction func selectAvatarImage(sender: UIButton) {
        currentImageSelection = 1
        showImagePickerMenu()
    }
    
    @IBAction func doRegister() {
        if textFieldFullName.text?.isEmpty == true {
            let image: UIImage = UIImage(named: "Edit User")!
            let banner = Banner(title: "Error".localized, subtitle: "Campo vacío".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        if textFieldEmail.text?.isEmpty == true {
            let image: UIImage = UIImage(named: "Edit User")!
            let banner = Banner(title: "Error".localized, subtitle: "Campo vacío".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        if textFieldPhone.text?.isEmpty == true {
            let image: UIImage = UIImage(named: "Edit User")!
            let banner = Banner(title: "Error".localized, subtitle: "Campo vacío".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        if textFieldPassword.text?.isEmpty == true {
            let image: UIImage = UIImage(named: "Edit User")!
            let banner = Banner(title: "Error".localized, subtitle: "Campo vacío".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        if textFieldPassword.text != textFieldRepeatPassword.text {
            let image: UIImage = UIImage(named: "Edit User")!
            let banner = Banner(title: "Error".localized, subtitle: "Contrasinal incorrecta".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        if avatarSelected == false {
            let image: UIImage = UIImage(named: "Edit User")!
            let banner = Banner(title: "Error".localized, subtitle: "Seleccione una imagen".localized, image: image, backgroundColor: FlatUIColors.pomegranateColor())
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            return
        }
        
        let userProfile = WUser(userName: textFieldEmail.text, fullName: textFieldFullName.text, email: textFieldEmail.text, phoneNumber: textFieldPhone.text, image: imageViewAvatar.image, password: textFieldPassword.text)
        
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler!.registerUser(userProfile)
        })
    }
}
