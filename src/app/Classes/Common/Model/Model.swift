//
//  Model.swift
//  app
//
//  Created by Manuel Alejandro on 9/16/16.
//  Copyright © 2016 Manuel Alejandro. All rights reserved.
//

import Foundation
import UIKit

struct WRecipe: Equatable {
    var id: String?
    var name: String?
    var rating: Int?
    var images: [String]?
    var details: String?
    var vegans: Bool?
    var vegetarians: Bool?
    var celiacs: Bool?
    var category: String?
    var local: WLocal?
    var tasted: Bool?
    var favorite: Bool?
}
func ==(first: WRecipe, second: WRecipe) -> Bool {
    return first.id == second.id
}

struct WLocal: Equatable {
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
func ==(first: WLocal, second: WLocal) -> Bool {
    return first.id == second.id
}

struct WCategory: Equatable {
    var id : String?
    var name : String?
    var image : String?
}
func ==(first: WCategory, second: WCategory) -> Bool {
    return first.id == second.id
}

struct WSearchCriteria {
    var name: String?
    var radio: Float?
    var category: WCategory?
    var celiacs: Bool?
    var vegetarian: Bool?
    var vegan: Bool?
}

class WLocalWrapper: NSObject {
    var local: WLocal?
}

struct WMenuItem {
    var name: String
    var image: UIImage
}

struct WUser {
    var userName: String?
    var fullName: String?
    var email: String?
    var phoneNumber: String?
    var image: UIImage?
    var password: String?
}

