//
//  WRecipeProfileViewController.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 19/09/16.
//
//

import UIKit
import Cosmos
import GoogleMaps
import BRYXBanner
import FlatUIColors
import MBProgressHUD
import SKPhotoBrowser

class WRecipeProfileViewController: UIViewController, WRecipeProfileViewInterface
{
    // MARK: - Outlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var scrollViewContainer: UIScrollView!
    
    // *** Top View
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var cosmosViewRaiting: CosmosView?
    @IBOutlet weak var imageViewRecipe: UIImageView!
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var buttonTasted: UIButton!
    
    // *** Decription view
    @IBOutlet weak var viewDescriptionContainer: UIView!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var viewDescriptionLayoutConstraint: NSLayoutConstraint!
    
    // *** Vote view
    @IBOutlet weak var viewVoteContainer: UIView!
    
    // *** Info View
    @IBOutlet weak var viewInfoContainer: UIView!
    @IBOutlet weak var tableViewInfo: UITableView!
    @IBOutlet weak var viewInfoContainerLayoutConstraint: NSLayoutConstraint!
    
    // *** Local details
    @IBOutlet weak var viewLocalContainer: UIView!
    @IBOutlet weak var imageViewLocal: UIImageView!
    @IBOutlet weak var labelLocalName: UILabel!
    @IBOutlet weak var labelLocalAddress: UILabel!
    @IBOutlet weak var labelLocalDistance: UILabel!
    
    // *** MapView
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    // *** Store
    var navigationBarBackgroundImage : UIImage!
    var navigationBarShadowImage : UIImage!
    
    // ***
    var loadingView: MBProgressHUD?
    var recipe: WRecipe?
    
    var eventHandler: WRecipeProfileModuleInterface?

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
        
        self.navigationController!.navigationBar.setBackgroundImage(navigationBarBackgroundImage, forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = navigationBarShadowImage
    }
    
    // MARK: - Private
    private func setupView() {
        viewDescriptionContainer.setupViewForApp()
        viewVoteContainer.setupViewForApp()
        viewInfoContainer.setupViewForApp()
        viewMapContainer.setupViewForApp()
        viewLocalContainer.setupViewForApp()
        
        let backBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .Plain, target: self, action: #selector(WRecipeProfileViewController.goBack))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        let shareBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Share"), style: .Plain, target: self, action: #selector(WRecipeProfileViewController.shareRecipe))
        
        let galleryBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Gallery"), style: .Plain, target: self, action: #selector(WRecipeProfileViewController.showGallery))
        
        self.navigationItem.rightBarButtonItems = [galleryBarButtonItem, shareBarButtonItem]
        
        cosmosViewRaiting?.settings.updateOnTouch = false
        cosmosViewRaiting?.settings.fillMode = .Full
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "presentModalRaitingVC" {
            let vc: WRatingViewController = segue.destinationViewController as! WRatingViewController
            vc.recipe = self.recipe
            vc.delegate = self
        }
    }

    // MARK: - WRecipeProfileViewInterface methods

    // *** implement view_interface methods here
    func updateViewWithRecipe(recipe: WRecipe) {
        self.recipe = recipe
        
        if recipe.favorite == true {
            buttonFavorite.setImage(UIImage(named: "Like-Fill"), forState: .Normal)
        } else {
            buttonFavorite.setImage(UIImage(named: "Like"), forState: .Normal)
        }
        
        if recipe.tasted == true {
            buttonTasted.setImage(UIImage(named: "Tasted Filled"), forState: .Normal)
        } else {
            buttonTasted.setImage(UIImage(named: "Tasted"), forState: .Normal)
        }
        
        labelTitle.text = recipe.name
        if recipe.images?.count > 0 {
            imageViewRecipe.image = UIImage(named: recipe.images![0])
        }
        cosmosViewRaiting?.rating = (recipe.rating?.toDouble)!
        textViewDescription.text = recipe.details
        
        let heightOfDescription = recipe.details?.heightWithConstrainedWidth(CGRectGetWidth(textViewDescription.frame), font: textViewDescription.font!)
        viewDescriptionLayoutConstraint.constant = heightOfDescription! + 83
        
        let local = recipe.local
        labelLocalName.text = local?.name
        labelLocalAddress.text = local?.address
        let currentLocation = WMainBoard.sharedInstance.currentLocation
        if currentLocation != nil {
            let localLocation = CLLocation(latitude: (local?.latitude)!, longitude: (local?.longitude)!)
            let distance = Utils.calculateDistance(currentLocation!, destination: localLocation)
            let km = distance / 1000
            labelLocalDistance.text = "A \(km)km da túa posición"
        } else {
            labelLocalDistance.text = ""
        }
        imageViewLocal.image = UIImage(named: (local?.image)!)
        
        loadMapViewDetails()
        self.view.layoutIfNeeded()
        
        let maxY = CGRectGetMaxY(viewMapContainer.frame)
        viewContainer.frame = CGRectMake(0, 0, CGRectGetWidth(viewContainer.frame), maxY + 8)
        let height = CGRectGetHeight(viewContainer.frame)
        scrollViewContainer.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), height)
        
        tableViewInfo.delegate = self
        tableViewInfo.dataSource = self
        tableViewInfo.reloadData()
        
        updateView()
        stopLoadingView()
    }
    
    func stopLoadingView() {
        if loadingView != nil {
            loadingView?.hideAnimated(true)
        }
    }

    // MARK: - Button event handlers

    // ** handle UI events here
    
    @IBAction func favoriteAction(sender: UIButton) {
        recipe?.favorite = !(recipe?.favorite)!
        if recipe!.favorite == true {
            buttonFavorite.setImage(UIImage(named: "Like-Fill"), forState: .Normal)
        } else {
            buttonFavorite.setImage(UIImage(named: "Like"), forState: .Normal)
        }
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateRecipe(self.recipe!)
        })
    }
    
    @IBAction func tastedAction(sender: UIButton) {
        recipe?.tasted = !(recipe?.tasted)!
        if recipe!.tasted == true {
            buttonTasted.setImage(UIImage(named: "Tasted Filled"), forState: .Normal)
        } else {
            buttonTasted.setImage(UIImage(named: "Tasted"), forState: .Normal)
        }
        startLoadingView()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateRecipe(self.recipe!)
        })
    }
    
    @IBAction func exploreToggled(sender: UIButton) {
        
    }
    
    @IBAction func navigateToggled(sender: UIButton) {
        
    }
    
    @IBAction func showLocalProfile(sender: UIButton) {
        eventHandler?.showLocalProfile((recipe?.local!)!, recipe:  recipe!)
    }
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func shareRecipe() {
        let imageToShare: UIImage = UIImage(named: (recipe?.images![0])!)!
        let textToShare: String = (recipe?.name)!
        let objectToShare:Array = [textToShare, imageToShare]
        let activityVC = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypePostToTencentWeibo, UIActivityTypePostToVimeo, UIActivityTypePostToFlickr, UIActivityTypeAddToReadingList, UIActivityTypeSaveToCameraRoll, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToWeibo]
        
        activityVC.popoverPresentationController?.sourceView = self.tabBarController?.tabBar
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func showGallery() {
        var photos = [SKPhotoProtocol]()
        for imageName in (recipe?.images)! {
            let image = UIImage(named: imageName)
            let photo = SKPhoto.photoWithImage(image!)
            photos.append(photo)
        }
        let browser = SKPhotoBrowser(photos: photos)
        presentViewController(browser, animated: true, completion: {})
    }
    
    @IBAction func rateRecipe() {
        
    }
}

extension WRecipeProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WRecipeProfileTableViewCell = tableView.dequeueReusableCellWithIdentifier("recipeInfoReuseIdentifier", forIndexPath: indexPath) as! WRecipeProfileTableViewCell
        cell.imageView?.contentMode = .ScaleAspectFit
        switch indexPath.row {
        case 0:
            let category = Utils.categoryByRecipeCategory(recipe!.category!)
            cell.imageViewInfo?.image = UIImage(named: category.image!)
            cell.labelInfo?.text = category.name
            break
        case 1:
            cell.imageViewInfo?.image = UIImage(named: "celiacos")
            if recipe?.celiacs == true {
                cell.labelInfo?.text = "Apta para celiacos"
            } else {
                cell.labelInfo?.text = "No apta para celiacos"
            }
            break
        case 2:
            cell.imageViewInfo?.image = UIImage(named: "icono vegetariano")
            if recipe?.vegetarians == true {
                cell.labelInfo?.text = "Apta para vexetarianos"
            } else {
                cell.labelInfo?.text = "No apta para vexetarianos"
            }
            break
        case 3:
            cell.imageViewInfo?.image = UIImage(named: "icono vegano")
            if recipe?.vegetarians == true {
                cell.labelInfo?.text = "Apta para veganos"
            } else {
                cell.labelInfo?.text = "No apta para veganos"
            }
            break
        default:
            cell.imageViewInfo?.image = UIImage(named: "Christmas Star")
            let text = "A túa puntuación: "
            let attributedString = NSMutableAttributedString(string:text)
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15),
                NSForegroundColorAttributeName: AppColors.blue]
            let boldString = NSMutableAttributedString(string:"\(recipe!.rating!)", attributes:attrs)
            attributedString.appendAttributedString(boldString)
            cell.labelInfo?.attributedText = attributedString
            break
        }
        
        return cell
    }
}

/// Google Maps
extension WRecipeProfileViewController: GMSMapViewDelegate {
    func loadMapViewDetails() {
        let local = recipe!.local
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

extension WRecipeProfileViewController: WRatingViewControllerDelegate {
    func setRaiting(rating: Int) {
        startLoadingView()
        recipe?.rating = rating
        cosmosViewRaiting?.rating = rating.toDouble
        tableViewInfo.reloadData()
        dispatch_async(dispatch_get_main_queue(),{
            self.eventHandler?.updateRecipe(self.recipe!)
        })
    }
}
