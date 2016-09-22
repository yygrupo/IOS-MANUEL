//
//  Model.swift
//  app
//
//  Created by Manuel Alejandro on 9/16/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import UIKit

struct WRecipe {
    var id: String?
    var name: String?
    var raiting: Int?
    var images: [UIImage]?
    
    var description: String?
    
    var vegans: Bool?
    var vegetarians: Bool?
    var suitableForVegans: Bool?
    
    var category: WCategory?
}

struct WPlace {
    var name: String?
    
    var address: String?
    var phoneNumber: String?
    var email: String?
    var description: String?
    
}

struct WCategory: Equatable {
    var id : String?
    var category_name : String?
    var category_image : String?
}

func ==(first: WCategory, second: WCategory) -> Bool {
    return first.category_name == second.category_name
}

