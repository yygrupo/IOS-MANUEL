//
//  GenericExtensions.swift
//  app
//
//  Created by Manuel Alejandro on 9/13/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toDouble: Double { return Double(self) }
}

extension Float {
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toDouble: Double { return Double(self) }
}

extension Double {
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toDouble: Double { return Double(self) }
}

extension CGFloat {
    var toFloat: Float { return Float(self) }
    var toDouble: Double { return Double(self) }
}