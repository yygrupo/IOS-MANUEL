//
//  Model.swift
//  app
//
//  Created by Manuel Alejandro on 9/16/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation

struct WRecipe {
    var cid : String?
    var category_name : String?
    var category_image : String?
    var status: Bool
    var wid: String?
    var worcipe_heading: String?
    var cat_id: String?
    var worcipe_status: String?
    var worcipe_image: String?
    var worcipe_content: String?
    var worcipe_ingredients: Int
    var worcipe_calories: Int
    var worcipe_fat: Int
    var worcipe_carbs: Int
    var worcipe_proteins: Int
    var worcipe_time: Int
    var worcipe_description: String?
}

struct WCategory: Equatable {
    var cid : String?
    var category_name : String?
    var category_image : String?
}

func ==(first: WCategory, second: WCategory) -> Bool {
    return first.category_name == second.category_name
}

