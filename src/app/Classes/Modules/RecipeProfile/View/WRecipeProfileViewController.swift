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

class WRecipeProfileViewController: UIViewController, WRecipeProfileViewInterface
{
    // MARK: - Outlets
    
    // *** Top View
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var cosmosViewRaiting: CosmosView?
    
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
    @IBOutlet weak var imageViewLocal: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    
    // *** MapView
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var eventHandler: WRecipeProfileModuleInterface?

    // MARK: - View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    // MARK: - WRecipeProfileViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here
    
    @IBAction func exploreToggled(sender: UIButton) {
        
    }
    
    @IBAction func navigateToggled(sender: UIButton) {
        
    }
}
