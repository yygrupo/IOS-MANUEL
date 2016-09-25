//
//  WRecipeRatedTableViewCell.swift
//  app
//
//  Created by Manuel Alejandro on 9/23/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit
import CoreLocation

class WRecipeRatedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewRecipe: UIImageView?
    @IBOutlet weak var labelLocalName: UILabel?
    @IBOutlet weak var labelStartDistance: UILabel?
    @IBOutlet weak var labelTravelTime: UILabel?
    @IBOutlet weak var labelRaiting: UILabel?
    @IBOutlet weak var labelRecipeName: UILabel?
    
    var recipe: WRecipe?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        labelTravelTime?.text = ""
        labelStartDistance?.text = ""
        labelLocalName?.text = ""
        labelRaiting?.text = ""
        labelRecipeName?.text = ""
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupView() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WRecipeRatedTableViewCell.calculateDistanceFromNotification(_:)), name: "NewLocation", object: nil)
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

    func updateViewWithRecipe(recipe: WRecipe) {
        self.recipe = recipe
        labelRecipeName?.text = recipe.name
        labelLocalName?.text = recipe.local?.name
        labelRaiting?.text = "\(recipe.rating!)"
        
        if recipe.images?.count > 0 {
            imageViewRecipe?.image = UIImage(named: recipe.images![0])
        }
        
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
