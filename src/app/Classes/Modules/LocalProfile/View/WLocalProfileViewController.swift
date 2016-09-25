//
//  WLocalProfileViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import UIKit
import Cosmos
import GoogleMaps
import MBProgressHUD

class WLocalProfileViewController: UIViewController, WLocalProfileViewInterface
{
    // MARK: - Outlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var scrollViewContainer: UIScrollView!
    
    // *** Info
    @IBOutlet weak var imageViewLocal: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelRecipeName: UILabel!
    
    // *** Info View
    @IBOutlet weak var viewInfoContainer: UIView!
    @IBOutlet weak var tableViewInfo: UITableView!
    @IBOutlet weak var viewInfoContainerLayoutConstraint: NSLayoutConstraint!
    
    // *** RecipeView
    @IBOutlet weak var viewRecipeContainer: UIView!
    @IBOutlet weak var tableViewRecipe: UITableView!
    @IBOutlet weak var viewRecipeContainerLayoutConstraint: NSLayoutConstraint!
    
    // *** MapView
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    // ***
    var loadingView: MBProgressHUD?
    var local: WLocal?
    
    // *** Store
    var navigationBarBackgroundImage : UIImage!
    var navigationBarShadowImage : UIImage!
    
    // MARK: - Events handler
    
    var eventHandler: WLocalProfileModuleInterface?
    
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
        viewInfoContainer.setupViewForApp()
        viewRecipeContainer.setupViewForApp()
        viewMapContainer.setupViewForApp()
        
        let backBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .Plain, target: self, action: #selector(WLocalProfileViewController.goBack))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        mapView.delegate = self
    }
    
    private func updateView() {
        navigationBarBackgroundImage = self.navigationController!.navigationBar.backgroundImageForBarMetrics(.Default)
        navigationBarShadowImage = self.navigationController!.navigationBar.shadowImage
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    func startLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
        loadingView = MBProgressHUD.showHUDAddedTo((self.navigationController?.view)!, animated: true)
        loadingView?.mode = MBProgressHUDMode.Indeterminate
    }
    
    // MARK: - WLocalProfileViewInterface methods
    
    // *** implement view_interface methods here
    
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }
    
    func updateViewWithLocal(local: WLocal, recipe: WRecipe?) {
        self.local = local
        
        imageViewLocal.image = UIImage(named: local.image!)
        labelName.text = local.name
        
        if recipe != nil {
            labelRecipeName.text = recipe?.name
        }
        
        let infoConstraintHeight: Int = 68 + 44 * 6
        viewInfoContainerLayoutConstraint.constant = infoConstraintHeight.toCGFloat
        tableViewInfo.tag = 10
        tableViewInfo.delegate = self
        tableViewInfo.dataSource = self
        tableViewInfo.reloadData()
        
        let recipesConstraintHeight: Int = 68 + 150 * ((local.recipes?.count)! + 1)
        viewRecipeContainerLayoutConstraint.constant = recipesConstraintHeight.toCGFloat
        tableViewRecipe.tag = 20
        tableViewRecipe.delegate = self
        tableViewRecipe.dataSource = self
        tableViewRecipe.reloadData()
        
        loadMapViewMarker()
        self.view.layoutIfNeeded()
        
        let maxY = CGRectGetMaxY(viewMapContainer.frame)
        viewContainer.frame = CGRectMake(0, 0, CGRectGetWidth(viewContainer.frame), maxY + 8)
        let height = CGRectGetHeight(viewContainer.frame)
        scrollViewContainer.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), height)
        
        updateView()
        stopLoadingView()
    }
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func exploreToggled(sender: UIButton) {
        
    }
    
    @IBAction func navigateToggled(sender: UIButton) {
        
    }
}

/// TableView Delagates and Datasource
extension WLocalProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10 {
            return 6
        } else {
            return (local?.recipes?.count)!
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 10 {
            return 44
        } else {
            return 150
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 10 {
            let cell = tableView.dequeueReusableCellWithIdentifier("localInfoReuseIdentifier", forIndexPath: indexPath)
            switch indexPath.row {
            case 0:
                cell.imageView?.image = UIImage(named: "Marker Fill Gray")
                cell.textLabel?.text = local?.address
                break
            case 1:
                let localCoordinate = CLLocation(latitude: (local?.latitude)!, longitude: (local?.longitude)!)
                let distanceInMeters = WMainBoard.sharedInstance.currentLocation!.distanceFromLocation(localCoordinate)
                let km = distanceInMeters / 1000
                cell.imageView?.image = UIImage(named: "Center Direction")
                cell.textLabel?.text = "\(km) km"
                break
            case 2:
                cell.imageView?.image = UIImage(named: "Walking")
                let localCoordinate = CLLocation(latitude: (local?.latitude)!, longitude: (local?.longitude)!)
                let distanceInMeters = WMainBoard.sharedInstance.currentLocation!.distanceFromLocation(localCoordinate)
                let minutes: Int = Int(distanceInMeters) / 100 + 1
                let hours: Int = minutes / 60
                if hours > 0 {
                    cell.textLabel?.text = String(hours) + " h"
                } else {
                    cell.textLabel?.text = String(minutes) + " min"
                }
                break
            case 3:
                cell.imageView?.image = UIImage(named: "Phone")
                cell.textLabel?.text = local?.phoneNumber
                break
            case 4:
                cell.imageView?.image = UIImage(named: "Message")
                cell.textLabel?.text = local?.address
                break
            default:
                cell.imageView?.image = UIImage(named: "Time")
                cell.textLabel?.text = ""
                break
            }
            return cell
        } else {
            let cell: WLocalRecipeTableViewCell = tableView.dequeueReusableCellWithIdentifier("recipeLocalReuseIdentifier", forIndexPath: indexPath) as! WLocalRecipeTableViewCell
            let recipe = local?.recipes![indexPath.row]
            cell.updateViewWithRecipe(recipe!)
            
            return cell
        }
    }
}

/// Google Maps
extension WLocalProfileViewController: GMSMapViewDelegate {
    func loadMapViewMarker() {
        let  position = CLLocationCoordinate2DMake((local?.latitude)!, (local?.longitude)!)
        let marker = GMSMarker(position: position)
        marker.title = local?.name
        marker.snippet = local?.address
        marker.map = mapView
        
        mapView.animateToLocation(position)
        mapView.animateToZoom(6)
        mapView.settings.setAllGesturesEnabled(false)
    }
}
