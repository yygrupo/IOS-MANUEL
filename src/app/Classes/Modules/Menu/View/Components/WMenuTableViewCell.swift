//
//  WMenuTableViewCell.swift
//  app
//
//  Created by Manuel Alejandro on 9/13/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import UIKit

class WMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuImageView: UIImageView?
    @IBOutlet weak var menuTitle: UILabel?
    @IBOutlet weak var menuSeparator: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
