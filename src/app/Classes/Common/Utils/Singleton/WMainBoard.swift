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
import ReachabilitySwift

class WMainBoard: NSObject {
    
    // MARK: - Initialization
    static let sharedInstance = WMainBoard()
    
    var locationRequest: Request?
    var currentLocation: CLLocation?
    var locals = [WLocal]()
    var categories = [WCategory]()
    var recipeProfile: WRecipe?
    var localProfile: WLocal?
    var searchCriteria: WSearchCriteria?
    var currentUser: WUser?
    var internetActive = false
    
    override init() {
        super.init()
        
        do {
            let reachability = try Reachability(hostname: "www.google.com")
            reachability.whenReachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                dispatch_async(dispatch_get_main_queue()) {
                    self.internetActive = true
                }
            }
            reachability.whenUnreachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                dispatch_async(dispatch_get_main_queue()) {
                    self.internetActive = true
                }
            }
            
            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        } catch {
            
        }
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
