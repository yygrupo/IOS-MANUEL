//
//  WHomeViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import UIKit
import BRYXBanner
import FlatUIColors
import MBProgressHUD
import AZDropdownMenu

class WHomeViewController: UIViewController, WHomeViewInterface, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate, UISearchControllerDelegate, UISearchResultsUpdating
{
    @IBOutlet weak var viewSearchBarContainer: UIView?
    @IBOutlet weak var collectionView: UICollectionView?
    var filterMenu: AZDropdownMenu?
    var sortMenu: AZDropdownMenu?
    
    // MARK: - Attributes
    var searchController: UISearchController?
    var isDataFiltered: Bool = false
    var loadingView: MBProgressHUD?
    var recipes: [WRecipe] = []
    var filteredData: [WRecipe] = []
    var categories: [WCategory] = []
    
    // MARK: - Events handlers
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
        
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateView()
        })
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
        
        //        let searchBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .Plain, target: self, action: #selector(WHomeViewController.searchAction(_:)))
        
        let sortBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Sorting Arrows"), style: .Plain, target: self, action: #selector(WHomeViewController.sortAction(_:)))
        
        let optionsBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu Circle"), style: .Plain, target: self, action: #selector(WHomeViewController.filtersAction(_:)))
        
        self.navigationItem.rightBarButtonItems = [optionsBarButtonItem, sortBarButtonItem]
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        UIApplication.sharedApplication().statusBarHidden = false
        
        searchController = ({
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.tintColor            = UIColor.whiteColor()
            searchController.searchBar.barTintColor         = AppColors.blue
            searchController.searchBar.placeholder         = "Escriba la frase..."
            
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
                    let searchTermMatches = self.searchString(recipe.worcipe_heading!, searchTerm: searchTerm).count > 0
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
        stopLoadingView()
        self.recipes = recipes
        collectionView?.reloadData()
    }
    
    func updateViewWithCategories(categories: [WCategory]) {
        self.categories = categories
        
        var dataSource: [AZDropdownMenuItemData] = []
        
        for category in categories {
            let data = AZDropdownMenuItemData(title:category.category_name!, icon:UIImage())
            dataSource.append(data)
        }
        
        filterMenu = AZDropdownMenu(dataSource: dataSource)
        filterMenu!.itemFontSize = 16.0
        filterMenu!.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
            
        }
    }
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
    
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    func filtersAction(sender: UIBarButtonItem) {
        if self.filterMenu?.isDescendantOfView(self.view) == true {
            self.filterMenu?.hideMenu()
        } else {
            self.filterMenu?.showMenuFromView(self.view)
        }

    }
    
    func sortAction(sender: UIBarButtonItem) {
        
    }
}
