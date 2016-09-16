//
//  WHomeViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit

class WHomeViewController: UIViewController, WHomeViewInterface, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate
{
    @IBOutlet weak var collectionView: UICollectionView?
    
    var eventHandler: WHomeModuleInterface?

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
        titleLabel.text = "Tapas".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WHomeViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        let searchBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .Plain, target: self, action: #selector(WHomeViewController.searchAction(_:)))
        
        let sortBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Sorting Arrows"), style: .Plain, target: self, action: #selector(WHomeViewController.sortAction(_:)))
        
        let optionsBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu Circle"), style: .Plain, target: self, action: #selector(WHomeViewController.filtersAction(_:)))
        
        self.navigationItem.rightBarButtonItems = [optionsBarButtonItem, sortBarButtonItem, searchBarButtonItem]
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    // MARK: - UICollectionView Datasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dishCellIdentifier", forIndexPath: indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = ScreenBounds.WIDTH * 0.5 - 14.0
        let height = width * 2
        return CGSizeMake(width, height)
    }

    // MARK: - WHomeViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    func searchAction(sender: UIBarButtonItem) {

    }
    
    func filtersAction(sender: UIBarButtonItem) {
        
    }
    
    func sortAction(sender: UIBarButtonItem) {
        
    }
}
