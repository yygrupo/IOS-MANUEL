//
//  WRecipeCollectionViewCell.swift
//  app
//
//  Created by Manuel Alejandro on 9/13/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit

class WRecipeCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
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
    }
    
}
