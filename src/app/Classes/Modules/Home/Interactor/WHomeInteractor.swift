//
//  WHomeInteractor.swift
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class WHomeInteractor: NSObject
{
    weak var presenter: WHomePresenter?
    var dataManager: WHomeDataManager?
    
    func findRecipes() {
        Alamofire.request(
            .GET, AppAPI.url, parameters: ["recipes": "all"], encoding: .URL)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on recipes=all")
                    print(response.result.error!)
                    return
                }
                
                var recipes: [WRecipe] = []
                
                if let value = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let result = JSON(value)
                    let worcipeAppData = result["WorcipeApp"].arrayValue
                    for recipe in worcipeAppData {
                        let cid = recipe["cid"].stringValue
                        let category_name = recipe["category_name"].stringValue
                        let category_image = AppAPI.resouresPath + recipe["category_image"].stringValue
                        let status = recipe["status"].boolValue
                        let wid = recipe["wid"].stringValue
                        let worcipe_heading = recipe["worcipe_heading"].stringValue
                        let cat_id = recipe["cat_id"].stringValue
                        let worcipe_status = recipe["worcipe_status"].stringValue
                        let worcipe_image = AppAPI.resouresPath + recipe["worcipe_image"].stringValue
                        let worcipe_description = recipe["worcipe_description"].stringValue
                        let worcipe_content = recipe["worcipe_content"].stringValue
                        let worcipe_ingredients = recipe["worcipe_ingredients"].intValue
                        let worcipe_calories = recipe["worcipe_calories"].intValue
                        let worcipe_fat = recipe["worcipe_fat"].intValue
                        let worcipe_carbs = recipe["worcipe_carbs"].intValue
                        let worcipe_proteins = recipe["worcipe_proteins"].intValue
                        let worcipe_time = recipe["worcipe_time"].intValue
                        
                        let wRecipe = WRecipe(cid: cid, category_name: category_name, category_image: category_image, status: status, wid: wid, worcipe_heading: worcipe_heading, cat_id: cat_id, worcipe_status: worcipe_status, worcipe_image: worcipe_image, worcipe_content: worcipe_content, worcipe_ingredients: worcipe_ingredients, worcipe_calories: worcipe_calories, worcipe_fat: worcipe_fat, worcipe_carbs: worcipe_carbs, worcipe_proteins: worcipe_proteins, worcipe_time: worcipe_time, worcipe_description: worcipe_description)
                        
                        recipes.append(wRecipe)
                    }
                }
                
                self.presenter?.updateViewWithRecipes(recipes)
        }
    }
}
