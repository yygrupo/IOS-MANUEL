//
//  WSearchResultViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 25/09/16.
//
//

import UIKit
import MBProgressHUD
import CoreLocation

class WSearchResultViewController: UIViewController, WSearchResultViewInterface, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate, UISearchControllerDelegate, UISearchResultsUpdating
{
    @IBOutlet weak var viewSearchBarContainer: UIView?
    @IBOutlet weak var collectionView: UICollectionView?
    
    // MARK: - Attributes
    var searchController: UISearchController?
    var isDataFiltered: Bool = false
    var loadingView: MBProgressHUD?
    var recipes: [WRecipe] = []
    var filteredData: [WRecipe] = []
    var categories: [WCategory] = []
    
    var eventHandler: WSearchResultModuleInterface?

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
        
        self.recipes.removeAll()
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateView()
        })
    }
    
    // MARK: - Private
    private func setupView() {
        let titleLabel = UILabel(frame: (self.navigationController?.navigationBar.frame)!)
        titleLabel.textAlignment = .Left
        titleLabel.text = "Resultado".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let sortBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Sorting Arrows"), style: .Plain, target: self, action: #selector(WSearchResultViewController.sortAction(_:)))
        
        self.navigationItem.rightBarButtonItem = sortBarButtonItem
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        UIApplication.sharedApplication().statusBarHidden = false
        
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
    
    // MARK: - UICollectionView Datasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = isDataFiltered ? filteredData.count : recipes.count
        return numberOfItems
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: WRecipeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("dishCellIdentifier", forIndexPath: indexPath) as! WRecipeCollectionViewCell
        
        let recipe : WRecipe = isDataFiltered ? filteredData[indexPath.row] : recipes[indexPath.row]
        
        cell.updateViewWithData(recipe)
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let recipe : WRecipe = isDataFiltered ? filteredData[indexPath.row] : recipes[indexPath.row]
        eventHandler?.presentRecipeDetail(recipe)
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
        //        let recipe = recipes[indexPath.row]
        //        if recipe.images?.count > 0 {
        //            let image = UIImage(named: recipe.images![0])
        //            height = width * (image?.size.height)! / (image?.size.width)!
        //        }
        
        return CGSizeMake(width, height)
    }
    
    // MARK: - Search
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
        collectionView?.reloadData()
    }
    
    func filterData() {
        if searchIsEmpty() {
            isDataFiltered = false
        } else {
            filteredData = recipes.filter({ (recipe) -> Bool in
                if let searchTerm = self.searchController?.searchBar.text {
                    let searchTermMatches = self.searchString(recipe.name!, searchTerm: searchTerm).count > 0
                    if searchTermMatches {
                        return true
                    }
                }
                return false
            })
            isDataFiltered = true
        }
    }
    
    // MARK: - WHomeViewInterface methods
    
    // *** implement view_interface methods here
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func updateViewWithRecipes(recipes: [WRecipe]) {
        self.recipes.removeAll()
        self.recipes = recipes
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
    
    func sortAlpa() {
        let result = recipes.sort { $0.name < $1.name }
        recipes.removeAll()
        recipes = result
        collectionView?.reloadData()
    }
    
    func sortByDistance() {
        let currentLocation = WMainBoard.sharedInstance.currentLocation
        let result = recipes.sort {
            let location0 = CLLocation(latitude: ($0.local?.latitude)!, longitude: ($0.local?.longitude)!)
            let location1 = CLLocation(latitude: ($1.local?.latitude)!, longitude: ($1.local?.longitude)!)
            let distance0 = currentLocation?.distanceFromLocation(location0)
            let distance1 = currentLocation?.distanceFromLocation(location1)
            return distance0 < distance1
        }
        recipes.removeAll()
        recipes = result
        collectionView?.reloadData()
    }
}

extension WSearchResultViewController: WSortSelectionTableViewControllerDelegate {
    func selectedIndex(index: Int, tag: Int) {
        if tag == 50 {
            
        } else {
            if index == 0 {
                sortByDistance()
            } else {
                sortAlpa()
            }
        }
    }
}