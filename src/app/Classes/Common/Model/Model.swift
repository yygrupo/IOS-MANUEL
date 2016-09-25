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
    var suitableForVegans: Bool?
    var category: String?
    var local: WLocal?
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

class WLocalWrapper: NSObject {
    var local: WLocal?
}

