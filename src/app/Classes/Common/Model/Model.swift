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
    var images: [String]?
    var details: String?
    var vegans: Bool?
    var vegetarians: Bool?
    var suitableForVegans: Bool?
    var category: String?
    var local: WLocal?
}

struct WLocal {
    var id: String?
    var name: String?
    var address: String?
    var phoneNumber: String?
    var email: String?
    var details: String?
    var recipes: [WRecipe]?
    var raiting: Int?
    var image: String?
    var latitude: Double?
    var longitude: Double?
}

struct WCategory: Equatable {
    var id : String?
    var name : String?
    var image : String?
}

func ==(first: WCategory, second: WCategory) -> Bool {
    return first.name == second.name
}

