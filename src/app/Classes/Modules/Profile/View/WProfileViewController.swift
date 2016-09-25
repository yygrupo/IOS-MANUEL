//
//  WProfileViewController.swift
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

class WProfileViewController: UIViewController, WProfileViewInterface, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    
    var eventHandler: WProfileModuleInterface?
    
    var loadingView: MBProgressHUD?
    var currentUser: WUser?
    
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
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateView()
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        currentUser?.image = imageViewUser.image
        currentUser?.fullName = textFieldFullName.text
        currentUser?.email = textFieldEmail.text
        currentUser?.phoneNumber = textFieldPhoneNumber.text
        eventHandler?.updateUser(currentUser!)
    }
    
    // MARK: - Private
    private func setupView() {
        let titleLabel = UILabel(frame: (self.navigationController?.navigationBar.frame)!)
        titleLabel.textAlignment = .Left
        titleLabel.text = "Perfil".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WProfileViewController.showMenuAction))
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
        
        actionSheetController.popoverPresentationController?.sourceView = imageViewUser! as UIView
        
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
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        if DeviceInfo.ISPHONE == true {
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            imagePicker.modalPresentationStyle = .Popover
            
            imagePicker.popoverPresentationController?.sourceView = imageViewUser as UIView
            imagePicker.popoverPresentationController?.sourceRect = imageViewUser.frame
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePicker delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageViewUser.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewUser.image = originalImage
        }
        
        imageViewUser.setNeedsDisplay()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }
    
    // MARK: - WProfileViewInterface methods
    
    // *** implement view_interface methods here
    
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func updateViewWithUser(user: WUser) {
        imageViewUser.image = user.image
        textFieldEmail.text = user.email
        textFieldFullName.text = user.fullName
        textFieldPhoneNumber.text = user.phoneNumber
        stopLoadingView()
        imageViewUser.setNeedsDisplay()
    }
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func logOut(sender: UIButton) {
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.logOut()
        })
    }
    
    var passwordTextField: UITextField!
    @IBAction func changePassword(sender: UIButton) {
        let alert = UIAlertController(title: "Cambiar contrasinal", message: "", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancelar".localized, style: .Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Aceptar".localized, style: .Default, handler:{ (UIAlertAction) in
            self.currentUser?.password = self.passwordTextField.text
        }))
        self.presentViewController(alert, animated: true, completion: {
        })
    }
    
    func configurationTextField(textField: UITextField!)
    {
        textField.placeholder = "Nueva contrasinal".localized
        passwordTextField = textField
        passwordTextField.secureTextEntry = true
    }
    
    @IBAction func changeImageAction(sender: UIButton) {
        showImagePickerMenu()
    }
}
