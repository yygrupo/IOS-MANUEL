//
//  WLocalViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit
import BRYXBanner
import FlatUIColors
import MBProgressHUD
import CoreLocation

class WLocalViewController: UIViewController, WLocalViewInterface, UIPopoverPresentationControllerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearchBarContainer: UIView?
    
    var eventHandler: WLocalModuleInterface?
    
    // MARK: - Attr
    var locals = [WLocal]()
    var isDataFiltered: Bool = false
    var filteredData: [WLocal] = []
    var searchController: UISearchController?
    var loadingView: MBProgressHUD?
    var categories: [WCategory] = []
    
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
        titleLabel.text = "Locáis".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WLocalViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        UIApplication.sharedApplication().statusBarHidden = false
        
        let sortBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Sorting Arrows"), style: .Plain, target: self, action: #selector(WLocalViewController.sortAction(_:)))
        
        let optionsBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu Circle"), style: .Plain, target: self, action: #selector(WLocalViewController.filtersAction(_:)))
        
        let mapBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Marker-Fill"), style: .Plain, target: self, action: #selector(WLocalViewController.showMap(_:)))
        
        self.navigationItem.rightBarButtonItems = [optionsBarButtonItem, sortBarButtonItem, mapBarButtonItem]
        
        searchController = ({
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.tintColor            = UIColor.whiteColor()
            searchController.searchBar.barTintColor         = AppColors.blueLight
            searchController.searchBar.placeholder         = "Escriba la frase...".localized
            
            //setup the search bar
            searchController.searchBar.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
            self.viewSearchBarContainer?.addSubview(searchController.searchBar)
            searchController.searchBar.sizeToFit()
            
            return searchController
        })()
        
        isDataFiltered = false
    }
    
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    // MARK: - WLocalViewInterface methods
    
    // *** implement view_interface methods here
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func updateViewWithLocal(locals: [WLocal]) {
        self.locals = locals
        sortByDistance()
        stopLoadingView()
    }
    
    func updateViewWithCategories(categories: [WCategory]) {
        self.categories = categories
    }
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    func filtersAction(sender: UIBarButtonItem) {
        let sender_view = sender.valueForKey("view") as! UIView
        
        var menuItems = [WMenuItem(name: "Todas".localized, image: UIImage(named: "logo-min")!)]
        for category in categories {
            menuItems.append(WMenuItem(name: category.name!, image: UIImage(named: category.image!)!))
        }
        
        let menu = WSortSelectionTableViewController(style: .Plain, menuItems: menuItems)
        menu.view.tag = 50
        menu.delegate = self
        
        menu.modalPresentationStyle = .Popover
        menu.preferredContentSize = CGSizeMake(200, 140)
        
        let popoverMenuViewController = menu.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.navigationController?.navigationBar
        popoverMenuViewController?.sourceRect = CGRect(
            x: sender_view.center.x + 20,
            y: sender_view.center.y + 100,
            width: 1,
            height: 1)
        presentViewController(
            menu,
            animated: true,
            completion: nil)
    }
    
    func sortAction(sender: UIBarButtonItem) {
        let sender_view = sender.valueForKey("view") as! UIView
        
        let menuItems = [WMenuItem(name: "Proximidade".localized, image: UIImage(named: "Marker Fill Gray")!), WMenuItem(name: "Alfabéticamente".localized, image: UIImage(named: "Alphabetical Sorting")!)]
        
        let menu = WSortSelectionTableViewController(style: .Plain, menuItems: menuItems)
        menu.view.tag = 100
        menu.delegate = self
        
        menu.modalPresentationStyle = .Popover
        menu.preferredContentSize = CGSizeMake(200, 70)
        
        let popoverMenuViewController = menu.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.navigationController?.navigationBar
        popoverMenuViewController?.sourceRect = CGRect(
            x: sender_view.center.x + 20,
            y: sender_view.center.y + 65,
            width: 1,
            height: 1)
        presentViewController(
            menu,
            animated: true,
            completion: nil)
    }
    
    func showMap(sender: UIBarButtonItem) {
        eventHandler?.showMap()
    }
    
    func sortAlpa() {
        let result = locals.sort { $0.name < $1.name }
        locals.removeAll()
        locals = result
        tableView.reloadData()
    }
    
    func sortByDistance() {
        let currentLocation = WMainBoard.sharedInstance.currentLocation
        let result = locals.sort {
            let location0 = CLLocation(latitude: ($0.latitude)!, longitude: ($0.longitude)!)
            let location1 = CLLocation(latitude: ($1.latitude)!, longitude: ($1.longitude)!)
            let distance0 = currentLocation?.distanceFromLocation(location0)
            let distance1 = currentLocation?.distanceFromLocation(location1)
            return distance0 < distance1
        }
        locals.removeAll()
        locals = result
        tableView.reloadData()
    }
}

extension WLocalViewController: WSortSelectionTableViewControllerDelegate {
    func selectedIndex(index: Int, tag: Int) {
        if tag == 50 {
            startLoadingView()
            if index == 0 {
                dispatch_async(dispatch_get_main_queue(),{
                    self.eventHandler?.updateView()
                })
            } else {
                let categoryId = categories[index - 1].id
                dispatch_async(dispatch_get_main_queue(),{
                    self.eventHandler?.findLocalsWithCategory(categoryId!)
                })
            }
        } else {
            if index == 0 {
                sortByDistance()
            } else {
                sortAlpa()
            }
        }
    }
}

extension WLocalViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfItems = isDataFiltered ? filteredData.count : locals.count
        return numberOfItems
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WLocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("localResuseIdentifier", forIndexPath: indexPath) as! WLocalTableViewCell
        let local : WLocal = isDataFiltered ? filteredData[indexPath.row] : locals[indexPath.row]
        cell.updateViewWithLocal(local)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let local : WLocal = isDataFiltered ? filteredData[indexPath.row] : locals[indexPath.row]
        eventHandler?.presentLocalDetail(local)
    }
}

extension WLocalViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func searchString(string: String, searchTerm:String) -> Array<AnyObject>
    {
        var matches:Array<AnyObject> = []
        do {
            let regex = try NSRegularExpression(pattern: searchTerm, options: [.CaseInsensitive, .AllowCommentsAndWhitespace])
            let range = NSMakeRange(0, string.characters.count)
            matches = regex.matchesInString(string, options: [], range: range)
        } catch _ {
        }
        return matches
    }
    
    func searchIsEmpty() -> Bool
    {
        if let searchTerm = self.searchController?.searchBar.text {
            return searchTerm.isEmpty
        }
        return true
    }
    
    //MARK:UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filterData()
        tableView.reloadData()
    }
    
    func filterData() {
        if searchIsEmpty() {
            isDataFiltered = false
        } else {
            filteredData = locals.filter({ (local) -> Bool in
                if let searchTerm = self.searchController?.searchBar.text {
                    let searchTermMatches = self.searchString(local.name!, searchTerm: searchTerm).count > 0
                    if searchTermMatches {
                        return true
                    }
                }
                return false
            })
            isDataFiltered = true
        }
    }
}
