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
import Fakery
import SwiftRandom

class WHomeInteractor: NSObject
{
    weak var presenter: WHomePresenter?
    var dataManager: WHomeDataManager?
    var recipeStack = [WRecipe]()
    var recipesToShow = [WRecipe]()
    
    func findRecipesWithCategory(categoryId: String) {
        dataManager?.findRecipesWithCategory(categoryId, completion: { (recipes) in
            self.recipeStack = recipes!
            WMainBoard.sharedInstance.locals = [WLocal]()
            self.findLocalFromRecipe()
        })
    }
    
    func findRecipes() {
        dataManager?.findCategories({ (categories) in
            WMainBoard.sharedInstance.categories = categories!
            self.presenter?.updateViewWithCategories(categories!)
        })
        recipeStack.removeAll()
        recipesToShow.removeAll()
        dataManager?.findRecipes({ (recipes) in
            if recipes?.count == 0 {
                self.generateDummyData()
            } else {
                self.recipeStack = recipes!
                WMainBoard.sharedInstance.locals = [WLocal]()
                self.findLocalFromRecipe()
            }
        })
    }
    
    func findLocalFromRecipe() {
        if recipeStack.count == 0 {
            self.presenter?.updateViewWithRecipes(recipesToShow)
            return
        }
        
        var recipe = recipeStack.removeFirst()
        dataManager?.findLocalFromRecipe(recipe, completion: { (local) in
            recipe.local = local
            self.recipesToShow.append(recipe)
            WMainBoard.sharedInstance.locals.append(local!)
            self.findLocalFromRecipe()
        })
    }
    
    func generateDummyData() {
        let locals = generateLocals()
        let categories = generateCategories()
        
        WMainBoard.sharedInstance.locals = locals
        WMainBoard.sharedInstance.categories = categories
        
        var recipes = [WRecipe]()
        
        for local in locals {
            for recipe in local.recipes! {
                recipes.append(recipe)
            }
        }
        dataManager?.saveCategories(categories, completion: {
            self.presenter?.updateViewWithCategories(categories)
            self.dataManager?.saveLocals(locals, completion: {
                self.presenter?.updateViewWithRecipes(recipes)
            })
        })
    }
    
    func generateCategories() -> [WCategory] {
//        let categoryI = WCategory(id: "0", name: "Todas", image: "logo-min")
        let categoryII = WCategory(id: "1", name: "Tradicionáis".localized, image: "tradicional")
        let categoryIII = WCategory(id: "2", name: "Creativas".localized, image: "creativa")
        let categoryIV = WCategory(id: "3", name: "Cóctels".localized, image: "coctel")
        
        let categories = [categoryII, categoryIII, categoryIV]
        
        return categories
    }
    
    func generateLocals() -> [WLocal] {
        let faker = Faker()
        let localNumbers = faker.number.randomInt(min: 10, max: 20)
        var locals = [WLocal]()
        
        for _ in 0...localNumbers {
            let id: String = String(faker.number.increasingUniqueId())
            let name = faker.app.name()
            let address = faker.address.streetAddress(includeSecondary: true)
            let phoneNumber = faker.phoneNumber.phoneNumber()
            let email = faker.internet.email()
            let details = faker.lorem.paragraphs(amount: 1)
            let raiting = faker.number.randomInt(min: 0, max: 5)
            let recipes = generateRecipes(faker)
            let image = localImage()
            let latitude = faker.address.latitude()
            let longitude = faker.address.longitude()
            var local = WLocal(id: id, name: name, address: address, phoneNumber: phoneNumber, email: email, details: details, recipes: recipes, raiting: raiting, image: image, latitude: latitude, longitude: longitude)
            
            var newRecipes = [WRecipe]()
            for recipe in recipes {
                var newRecipe = recipe
                newRecipe.local = local
                newRecipes.append(newRecipe)
            }
            local.recipes = newRecipes
            
            locals.append(local)
        }
        
        return locals
    }
    
    func generateRecipes(faker: Faker) -> [WRecipe] {
        var recipes = [WRecipe]()
    
        let recipesNumber = faker.number.randomInt(min: 5, max: 15)
        
        for _ in 0...recipesNumber {
            let id: String = String(faker.number.increasingUniqueId())
            let name = faker.commerce.productName()
            let details = faker.lorem.paragraphs(amount: 1)
            let raiting = 0
            let vegans = faker.number.randomBool()
            let vegetarians = faker.number.randomBool()
            let celiacs = faker.number.randomBool()
            let category = faker.number.randomInt(min: 1, max: 3)
            let images = imagesFromCategory(category)
            
            let recipe = WRecipe(id: id, name: name, rating: raiting, images: images, details: details, vegans: vegans, vegetarians: vegetarians, celiacs: celiacs, category: String(category), local: nil, tasted: false, favorite: false)
            recipes.append(recipe)
        }
        
        return recipes
    }
    
    func imagesFromCategory(category: Int) -> [String] {
        var imagesPath = [String]()
        let imagesCount = Int.random(3, 5)
        for _ in 0...imagesCount {
            switch category {
            case 1:
                imagesPath.append(traditionalImage())
                break
            case 2:
                imagesPath.append(creativeImage())
                break
            case 3:
                imagesPath.append(coctelesImage())
                break
            default:
                imagesPath.append(allImage())
                break
            }
        }
        return imagesPath
    }
    
    func creativeImage() -> String {
        var imagesArray = ["cf1.jpg", "cf2.jpg", "cf3.jpg", "cf4.jpg", "cf5.jpg", "cf6.jpg"]
        imagesArray[0..<imagesArray.count].randomItem() // Array slice
        return imagesArray.randomItem()
    }
    
    func traditionalImage() -> String {
        var imagesArray = ["t1.jpg", "t2.jpg", "t3.jpg", "t4.jpg", "t5.jpg", "t6.jpg", "t7.jpg", "t8.jpg"]
        imagesArray[0..<imagesArray.count].randomItem() // Array slice
        return imagesArray.randomItem()
    }
    
    func coctelesImage() -> String {
        var imagesArray = ["c1.jpg", "c2.jpg", "c3.jpg", "c4.jpg", "c5.jpg", "c6.jpg"]
        imagesArray[0..<imagesArray.count].randomItem() // Array slice
        return imagesArray.randomItem()
    }
    
    func allImage() -> String {
        var imagesArray = ["a1.jpg", "a2.jpg", "a3.jpg", "a4.jpg", "a5.jpg", "a6.jpg", "a7.jpg", "a8.jpg"]
        imagesArray[0..<imagesArray.count].randomItem() // Array slice
        return imagesArray.randomItem()
    }
    
    func localImage() -> String {
        var imagesArray = ["l1.jpg", "l2.jpg", "l3.jpg", "l4.jpg", "l5.jpg", "l6.jpg", "l7.jpg", "l8.jpg"]
        imagesArray[0..<imagesArray.count].randomItem() // Array slice
        return imagesArray.randomItem()
    }
}

//    func findRecipes() {
//        Alamofire.request(
//            .GET, AppAPI.url, parameters: ["recipes": "all"], encoding: .URL)
//            .responseJSON { (response) -> Void in
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling GET on recipes=all")
//                    print(response.result.error!)
//                    return
//                }
//                var recipes: [WRecipe] = []
//                if let value = response.result.value {
//                    // handle the results as JSON, without a bunch of nested if loops
//                    let result = JSON(value)
//                    let worcipeAppData = result["WorcipeApp"].arrayValue
//                    for recipe in worcipeAppData {
//                        let cid = recipe["cid"].stringValue
//                        let category_name = recipe["category_name"].stringValue
//                        let category_image = AppAPI.resouresPath + recipe["category_image"].stringValue
//                        let status = recipe["status"].boolValue
//                        let wid = recipe["wid"].stringValue
//                        let worcipe_heading = recipe["worcipe_heading"].stringValue
//                        let cat_id = recipe["cat_id"].stringValue
//                        let worcipe_status = recipe["worcipe_status"].stringValue
//                        let worcipe_image = AppAPI.resouresPath + recipe["worcipe_image"].stringValue
//                        let worcipe_description = recipe["worcipe_description"].stringValue
//                        let worcipe_content = recipe["worcipe_content"].stringValue
//                        let worcipe_ingredients = recipe["worcipe_ingredients"].intValue
//                        let worcipe_calories = recipe["worcipe_calories"].intValue
//                        let worcipe_fat = recipe["worcipe_fat"].intValue
//                        let worcipe_carbs = recipe["worcipe_carbs"].intValue
//                        let worcipe_proteins = recipe["worcipe_proteins"].intValue
//                        let worcipe_time = recipe["worcipe_time"].intValue
//
//                        let wRecipe = WRecipe(cid: cid, category_name: category_name, category_image: category_image, status: status, wid: wid, worcipe_heading: worcipe_heading, cat_id: cat_id, worcipe_status: worcipe_status, worcipe_image: worcipe_image, worcipe_content: worcipe_content, worcipe_ingredients: worcipe_ingredients, worcipe_calories: worcipe_calories, worcipe_fat: worcipe_fat, worcipe_carbs: worcipe_carbs, worcipe_proteins: worcipe_proteins, worcipe_time: worcipe_time, worcipe_description: worcipe_description)
//
//                        recipes.append(wRecipe)
//                    }
//                }

//                self.presenter?.updateViewWithRecipes(recipes)
//        }
//    }
