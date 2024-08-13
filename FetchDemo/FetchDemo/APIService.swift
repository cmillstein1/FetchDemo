//
//  APIService.swift
//  FetchDemo
//
//  Created by Casey Millstein New on 8/12/24.
//

import Foundation

class APIService {
    private let dessertURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealsURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetchDesserts() async throws -> [Meal] {
        guard let url = URL(string: dessertURL) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealItemList = try JSONDecoder().decode([String: [Meal]].self, from: data)
        
        return mealItemList["meals"] ?? []
    }
    
    func fetchMealDetails(id: String) async throws -> MealDetail {
        guard let url = URL(string: mealsURL + id) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealDetailList = try JSONDecoder().decode([String: [MealDetail]].self, from: data)
        
        if let details = mealDetailList["meals"]?.first {
            return details
        }
        
        throw URLError(.badURL)
    }
}
