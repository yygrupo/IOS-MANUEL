//
//  WRateViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit
import AVFoundation
import QRCodeReader
import BRYXBanner
import FlatUIColors
import MBProgressHUD

class WRateViewController: UIViewController, WRateViewInterface
{
    @IBOutlet weak var containerView: UIView?
    
    var loadingView: MBProgressHUD?
    
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
    
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }

    // MARK: - WRateViewInterface methods

    // *** implement view_interface methods here
    func internetNotActive() {
        stopLoadingView()
        
        let alert = UIAlertController(
            title: "Información".localized,
            message: "AHORA MISMO NO TIENE COBERTURA POR LOQ UE NO PUEDE VOTAR. HEMOS GUARDADO EL CÓDIGO. CUANDO TENGAS COBERTURA RECIBIRÁS UNA NOTIFICACION Y PODRÁS VOTAR.".localized,
            preferredStyle: .Alert
        )
        alert.addAction(UIAlertAction(title: "OK".localized, style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
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
    
    @IBAction func scanQRCode(sender: UIButton) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            let reader = createReader()
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            
            reader.completionBlock = { (result: QRCodeReaderResult?) in
                if let result = result {
                    print("Completion with result: \(result.value) of type \(result.metadataType)")
                }
            }
            
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error".localized, message: "Lector no soportado".localized, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK".localized, style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func createReader() -> QRCodeReaderViewController {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            builder.showTorchButton = true
            builder.showCancelButton = true
        }
        
        return QRCodeReaderViewController(builder: builder)
    }
}

extension WRateViewController: QRCodeReaderViewControllerDelegate {
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true) { [weak self] in
            //self?.eventHandler?.codeDetected(result.value)
        }
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
