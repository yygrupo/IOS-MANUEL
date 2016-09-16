//
//  UIViewExtension.swift
//  app
//
//  Created by Manuel Alejandro on 9/14/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupViewForApp() {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        self.layer.borderColor = UIColor(red: 218, green: 218, blue: 218).CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 2.0
        
        self.layer.shadowColor =  UIColor(red: 218, green: 218, blue: 218).CGColor
        self.layer.shadowOffset = CGSizeMake(5.0, 5.0)
        self.layer.shadowRadius = 2.0
    }
}