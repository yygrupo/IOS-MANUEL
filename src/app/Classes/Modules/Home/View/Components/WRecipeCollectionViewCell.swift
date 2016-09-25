//
//  WRecipeCollectionViewCell.swift
//  app
//
//  Created by Manuel Alejandro on 9/13/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit
import MapleBacon
import Cosmos
import CoreLocation

class WRecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelRecipeName: UILabel?
    @IBOutlet weak var imageViewRecipe: UIImageView?
    @IBOutlet weak var labelLocalName: UILabel?
    @IBOutlet weak var labelAddress: UILabel?
    @IBOutlet weak var labelStartDistance: UILabel?
    @IBOutlet weak var labelTravelTime: UILabel?
    @IBOutlet weak var cosmosViewRaiting: CosmosView?
    @IBOutlet weak var imageViewTasted: UIImageView!
    
    var recipe: WRecipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        labelTravelTime?.text = ""
        labelStartDistance?.text = ""
        labelAddress?.text = ""
        labelLocalName?.text = ""
        labelRecipeName?.text = ""
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupView() {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        self.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5).CGColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 2.0
        
        self.layer.shadowColor = UIColor.lightGrayColor().CGColor
        self.layer.shadowOffset = CGSizeMake(-5.0, -5.0)
        self.layer.shadowRadius = 5.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WRecipeCollectionViewCell.calculateDistanceFromNotification(_:)), name: "NewLocation", object: nil)
        
        cosmosViewRaiting?.settings.updateOnTouch = false
    }
    
    func calculateDistanceFromNotification(notification: NSNotification) {
        if recipe == nil {
            return
        }
        
        let localCoordinate = CLLocation(latitude: (recipe?.local?.latitude)!, longitude: (recipe?.local?.longitude)!)
        let userLocation = notification.object as! CLLocation
        
        let distanceInMeters = userLocation.distanceFromLocation(localCoordinate)
        let km = distanceInMeters / 1000
        labelStartDistance?.text = String(km) + "km"
        
        let minutes: Int = Int(distanceInMeters) / 100 + 1
        let hours: Int = minutes / 60
        if hours > 0 {
            labelTravelTime?.text = String(hours) + "h"
        } else {
            labelTravelTime?.text = String(minutes) + "min"
        }
    }
    
    func updateViewWithData(recipe: WRecipe) {
        self.recipe = recipe
        labelRecipeName?.text = recipe.name
        labelLocalName?.text = recipe.local?.name
        labelAddress?.text = recipe.local?.address
        cosmosViewRaiting?.rating = (recipe.rating?.toDouble)!
        if recipe.images?.count > 0 {
            imageViewRecipe?.image = UIImage(named: recipe.images![0])
        }
        
        imageViewTasted.hidden = !recipe.tasted!
        
        if WMainBoard.sharedInstance.currentLocation == nil {
            WMainBoard.sharedInstance.locationRequest?.start()
        } else {
            let localCoordinate = CLLocation(latitude: (self.recipe?.local?.latitude)!, longitude: (self.recipe?.local?.longitude)!)
            
            let distanceInMeters = WMainBoard.sharedInstance.currentLocation!.distanceFromLocation(localCoordinate)
            let km = distanceInMeters / 1000
            labelStartDistance?.text = String(km) + "km"
            
            let minutes: Int = Int(distanceInMeters) / 100 + 1
            let hours: Int = minutes / 60
            if hours > 0 {
                labelTravelTime?.text = String(hours) + "h"
            } else {
                labelTravelTime?.text = String(minutes) + "min"
            }
        }
    }
}
