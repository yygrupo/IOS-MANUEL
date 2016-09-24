//
//  WLocalTableViewCell.swift
//  app
//
//  Created by Manuel Alejandro on 9/23/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit
import CoreLocation

class WLocalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewLocal: UIImageView?
    @IBOutlet weak var labelLocalName: UILabel?
    @IBOutlet weak var labelAddress: UILabel?
    @IBOutlet weak var labelStartDistance: UILabel?
    @IBOutlet weak var labelTravelTime: UILabel?
    @IBOutlet weak var labelCreativeFood: UILabel?
    @IBOutlet weak var labelTraditionalFood: UILabel?
    
    var local: WLocal?

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
        labelAddress?.text = ""
        labelLocalName?.text = ""
        labelCreativeFood?.text = ""
        labelTraditionalFood?.text = ""
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupView() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WLocalTableViewCell.calculateDistanceFromNotification(_:)), name: "NewLocation", object: nil)
    }
    
    func calculateDistanceFromNotification(notification: NSNotification) {
        if local == nil {
            return
        }
        
        let localCoordinate = CLLocation(latitude: (local?.latitude)!, longitude: (local?.longitude)!)
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
    
    func updateViewWithLocal(local: WLocal) {
        self.local = local
        
        labelLocalName?.text = local.name
        labelAddress?.text = local.address
        imageViewLocal?.image = UIImage(named: local.image!)
        
        var traditional = ""
        var creative = ""
        
        for recipe in local.recipes! {
            if recipe.category == "2" && traditional.isEmpty == true {
                traditional = recipe.name!
            } else if recipe.category == "3" && creative.isEmpty == true {
                creative = recipe.name!
            }
            
            if traditional.isEmpty == false && creative.isEmpty == false {
                break
            }
        }
        
        labelCreativeFood?.text = creative
        labelTraditionalFood?.text = traditional
        
        if WMainBoard.sharedInstance.currentLocation == nil {
            WMainBoard.sharedInstance.locationRequest?.start()
        } else {
            let localCoordinate = CLLocation(latitude: (local.latitude)!, longitude: (local.longitude)!)
            
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
