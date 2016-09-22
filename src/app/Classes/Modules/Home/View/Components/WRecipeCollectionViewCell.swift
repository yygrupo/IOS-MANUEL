//
//  WRecipeCollectionViewCell.swift
//  app
//
//  Created by Manuel Alejandro on 9/13/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit
import MapleBacon
import Cosmos

class WRecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelRecipeName: UILabel?
    @IBOutlet weak var imageViewRecipe: UIImageView?
    @IBOutlet weak var labelLocalName: UILabel?
    @IBOutlet weak var labelAddress: UILabel?
    @IBOutlet weak var labelStartDistance: UILabel?
    @IBOutlet weak var labelEndDistance: UILabel?
    @IBOutlet weak var cosmosViewRaiting: CosmosView?
    
    
    var recipe: WRecipe?
    
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
    
    func updateViewWithData(recipe: WRecipe) {
        self.recipe = recipe
        
        labelRecipeName?.text = recipe.worcipe_heading
        
        if let imageURL = NSURL(string: recipe.worcipe_image!), placeholder = UIImage(named: "Hourglass Sand Top") {
            imageViewRecipe!.setImageWithURL(imageURL, placeholder: placeholder)
        }
        labelLocalName?.text = recipe.worcipe_description
    }
    
}
