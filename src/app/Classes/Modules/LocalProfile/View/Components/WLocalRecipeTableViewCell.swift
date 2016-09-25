//
//  WLocalRecipeTableViewCell.swift
//  app
//
//  Created by male on 9/24/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit
import Cosmos

class WLocalRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelRecipeName: UILabel!
    @IBOutlet weak var labelRecipeCategory: UILabel!
    @IBOutlet weak var imageViewRecipeInfo: UIImageView!
    @IBOutlet weak var cosmosViewRating: CosmosView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cosmosViewRating!.settings.updateOnTouch = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViewWithRecipe(recipe: WRecipe) {
        labelRecipeName.text = recipe.name
        if recipe.images?.count > 0 {
            imageViewRecipeInfo.image = UIImage(named: recipe.images![0])
        }
        let category = Utils.categoryByRecipeCategory(recipe.category!)
        labelRecipeCategory.text = category.name
        cosmosViewRating?.rating = (recipe.rating?.toDouble)!
    }
}
