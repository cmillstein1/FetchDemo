//
//  MealModels.swift
//  FetchDemo
//
//  Created by Casey Millstein New on 8/12/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String {
        idMeal
    }
}

struct MealDetail: Codable {
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    
    var ingredients: [String] {
        var ingredientList = [String]()
        let mirror = Mirror(reflecting: self)
        for i in 1...20 {
            if let ingredient = mirror.descendant("strIngredient\(i)") as? String,
               let measure = mirror.descendant("strMeasure\(i)") as? String,
               !ingredient.isEmpty {
                ingredientList.append("\(ingredient) = \(measure)")
            }
        }
        
        return ingredientList
    }
    
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
           strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
           strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
           strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
       
       let strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
           strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
           strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
           strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?
}
