//
//  WMainBoard.swift
//  app
//
//  Created by Manuel Alejandro on 9/23/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit
import SwiftLocation
import CoreLocation

class WMainBoard: NSObject {

    // MARK: - Initialization
    static let sharedInstance = WMainBoard()
    
    var locationRequest: Request?
    var currentLocation: CLLocation?
    var locals = [WLocal]()
    var categories = [WCategory]()
    
    override init() {
        super.init()
    }
    
    func startUpdatingLocation() {
        locationRequest = Location.getLocation(withAccuracy: .Block, frequency: .ByDistanceIntervals(meters: 20), timeout: 50, onSuccess: { (location) in
            self.currentLocation = location
            NSNotificationCenter.defaultCenter().postNotificationName("NewLocation", object: location)
        }) { (lastValidLocation, error) in
        }
        locationRequest?.start()
    }
}
