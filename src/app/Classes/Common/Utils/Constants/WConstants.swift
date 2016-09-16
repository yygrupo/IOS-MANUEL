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