//
//  MealDetailView.swift
//  FetchDemo
//
//  Created by Casey Millstein New on 8/12/24.
//

import SwiftUI

struct MealDetailView: View {
    @State private var mealDetail: MealDetail?
    private let apiService = APIService()
    let mealId: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let mealDetails = mealDetail {
                    AsyncImage(url: URL(string: mealDetails.strMealThumb)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                    }
                        
                    
                    Text(mealDetails.strMeal)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 10)
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(mealDetails.ingredients, id: \.self) { ingredient in
                            
                            Text("• \(ingredient)")
                                .padding(.leading, 5)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(formatInstructions(mealDetails.strInstructions), id: \.self) { instruction in
                            
                            Text("• \(instruction)")
                                .padding(.leading, 8)
                        }
                    }

                } else {
                    Text("Loading...")
                        .task {
                            do {
                                mealDetail = try await apiService.fetchMealDetails(id: mealId)
                            } catch {
                                print("Error fetching meal details: \(error.localizedDescription)")
                            }
                        }
                }
            }
            .padding()
        }
    }
    
    private func formatInstructions(_ instructions: String) -> [String] {
        instructions.components(separatedBy: ". ")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter { !$0.isEmpty }
    }
}

#Preview {
    MealDetailView(mealId: "52897")
}
