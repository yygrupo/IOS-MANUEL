//
//  WConstants.swift
//  app
//
//  Created by Manuel Alejandro on 9/13/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import UIKit

struct ScreenBounds {
    static let HEIGHT : CGFloat = UIScreen.mainScreen().bounds.height
    static let WIDTH : CGFloat = UIScreen.mainScreen().bounds.width
}

struct DeviceInfo {
    static let VERSION : String = UIDevice.currentDevice().systemVersion
    static let ISPHONE : Bool = (UIDevice.currentDevice().userInterfaceIdiom == .Phone) ? true : false
}

struct AppColors {
    static let blue = UIColor(hexString: "#1A4682")
    static let blueLight = UIColor(red: 59, green: 96, blue: 147)
}

struct AppAPI {
    static let url = "http://worcipe.3wia.com/api.php"
    static let resouresPath = "http://worcipe.3wia.com/upload/"
    static let googleMaps = "AIzaSyB8vuk-tyI565RPrZPOnItytdahAP2z4Aw"
    
//    static let url = "http://localhost/projects/worcipe/api.php"
//    static let resouresPath = "http://localhost/projects/worcipe/upload/"
}