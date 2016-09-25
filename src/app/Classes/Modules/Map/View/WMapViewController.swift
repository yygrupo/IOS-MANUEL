//
//  WMapViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import UIKit
import GoogleMaps
import MBProgressHUD

class WMapViewController: UIViewController, WMapViewInterface
{
    @IBOutlet weak var mapView: GMSMapView!
    
    var locals = [WLocal]()
    var loadingView: MBProgressHUD?
    
    var eventHandler: WMapModuleInterface?

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
    
    // MARK: - Private
    private func setupView() {
        let titleLabel = UILabel(frame: (self.navigationController?.navigationBar.frame)!)
        titleLabel.textAlignment = .Left
        titleLabel.text = "Mapa".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WMapViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        mapView.delegate = self
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.myLocationEnabled = true
    }
    
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }

    // MARK: - WMapViewInterface methods

    // *** implement view_interface methods here
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func updateViewWithLocal(locals: [WLocal]) {
        self.locals = locals
        loadMapMarkers()
        stopLoadingView()
    }

    // MARK: - Button event handlers

    // ** handle UI events here

    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
}

extension WMapViewController : GMSMapViewDelegate {
    func loadMapMarkers() {
        let cameraBounds = GMSCoordinateBounds()
        for local in locals {
            let position = CLLocationCoordinate2DMake((local.latitude)!, (local.longitude)!)
            let marker = GMSMarker(position: position)
            marker.title = local.name
            marker.snippet = local.address
            marker.map = mapView
            let localWrapper = WLocalWrapper()
            localWrapper.local = local
            marker.userData = localWrapper
            cameraBounds.includingCoordinate(position)
        }
        
        let cameraUpdate = GMSCameraUpdate.fitBounds(cameraBounds)
        mapView.moveCamera(cameraUpdate)
        mapView.animateToViewingAngle(50)

        mapView.animateToZoom(2)
    }
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        let localWrapper = marker.userData as! WLocalWrapper
        eventHandler?.showLocalProfile(localWrapper.local!)
    }
}
