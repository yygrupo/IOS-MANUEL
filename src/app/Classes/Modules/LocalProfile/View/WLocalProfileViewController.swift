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

class WLocalProfileViewController: UIViewController, WLocalProfileViewInterface
{
    // MARK: - Outlets
    @IBOutlet weak var imageViewRecipe: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    
    // *** Info View
    @IBOutlet weak var viewInfoContainer: UIView!
    @IBOutlet weak var tableViewInfo: UITableView!
    @IBOutlet weak var viewInfoContainerLayoutConstraint: NSLayoutConstraint!
    
    // *** RecipeView
    @IBOutlet weak var viewRecipeContainer: UIView!
    @IBOutlet weak var labelRecipeName: UILabel!
    @IBOutlet weak var labelRecipeCategory: UILabel!
    @IBOutlet weak var imageViewRecipeInfo: UIImageView!
    @IBOutlet weak var cosmosViewRaiting: CosmosView?
    
    // *** MapView
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
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
    }
    
    // MARK: - Private
    private func setupView() {
        viewInfoContainer.setupViewForApp()
        viewRecipeContainer.setupViewForApp()
        viewMapContainer.setupViewForApp()
    }

    // MARK: - WLocalProfileViewInterface methods

    // *** implement view_interface methods here

    // MARK: - Button event handlers

    // ** handle UI events here
    
    @IBAction func exploreToggled(sender: UIButton) {
        
    }
    
    @IBAction func navigateToggled(sender: UIButton) {
        
    }
}
