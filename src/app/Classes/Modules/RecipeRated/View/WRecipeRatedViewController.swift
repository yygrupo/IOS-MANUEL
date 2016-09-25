//
//  WRecipeRatedViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 23/09/16.
//
//

import UIKit
import BRYXBanner
import FlatUIColors
import MBProgressHUD

class WRecipeRatedViewController: UIViewController, WRecipeRatedViewInterface
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearchBarContainer: UIView?
    
    var eventHandler: WRecipeRatedModuleInterface?
    
    // MARK: - Attr
    var recipes = [WRecipe]()
    var isDataFiltered: Bool = false
    var filteredData = [WRecipe]()
    var searchController: UISearchController?
    var loadingView: MBProgressHUD?

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
        
        recipes.removeAll()
        filteredData.removeAll()
        self.tableView.reloadData()
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateView()
        })
    }
    
    // MARK: - Private
    private func setupView() {
        let titleLabel = UILabel(frame: (self.navigationController?.navigationBar.frame)!)
        titleLabel.textAlignment = .Left
        titleLabel.text = "Puntuados".localized
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = titleLabel
        
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .Plain, target: self, action: #selector(WRecipeRatedViewController.showMenuAction))
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
        
        UIApplication.sharedApplication().statusBarHidden = false
        
        let sortBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Sorting Arrows"), style: .Plain, target: self, action: #selector(WRecipeRatedViewController.sortAction(_:)))
        
        let optionsBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu Circle"), style: .Plain, target: self, action: #selector(WRecipeRatedViewController.filtersAction(_:)))
        
        self.navigationItem.rightBarButtonItems = [optionsBarButtonItem, sortBarButtonItem]
        
        searchController = ({
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.tintColor            = UIColor.whiteColor()
            searchController.searchBar.barTintColor         = AppColors.blueLight
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

    // MARK: - WRecipeRatedViewInterface methods

    // *** implement view_interface methods here
    
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func updateViewWithRecipes(recipes: [WRecipe]) {
        stopLoadingView()
        self.recipes = recipes
        tableView.reloadData()
    }

    // MARK: - Button event handlers

    // ** handle UI events here
    func showMenuAction() {
        self.slideMenuController()?.openLeft()
    }
    
    func filtersAction(sender: UIBarButtonItem) {
        
    }
    
    func sortAction(sender: UIBarButtonItem) {
        
    }
}

extension WRecipeRatedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfItems = isDataFiltered ? filteredData.count : recipes.count
        return numberOfItems
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WRecipeRatedTableViewCell = tableView.dequeueReusableCellWithIdentifier("recipeRatedResuseIdentifier", forIndexPath: indexPath) as! WRecipeRatedTableViewCell
        cell.updateViewWithRecipe(recipes[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let recipe : WRecipe = isDataFiltered ? filteredData[indexPath.row] : recipes[indexPath.row]
        eventHandler?.presentRecipeDetail(recipe)
    }
}

extension WRecipeRatedViewController: UISearchControllerDelegate, UISearchResultsUpdating {
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
    
}
