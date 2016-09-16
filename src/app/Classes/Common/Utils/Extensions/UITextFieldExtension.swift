//
//  UITextFieldExtension.swift
//  app
//
//  Created by Manuel Alejandro on 9/13/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    /// Set placeholder color from UI
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                            attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
