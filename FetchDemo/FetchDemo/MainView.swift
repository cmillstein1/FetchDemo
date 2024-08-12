//
//  MainView.swift
//  FetchDemo
//
//  Created by Casey Millstein New on 8/12/24.
//

import SwiftUI

struct MainView: View {
    @State private var meals: [Meal] = []
    private let apiService = APIService()
    
    var body: some View {
        NavigationView {
            List(meals.sorted {
                $0.strMeal < $1.strMeal
            }) { meal in
                ZStack {
                    NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                        EmptyView()
                    }
                    .opacity(0)
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading) {
                            Text(meal.strMeal)
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(UIColor.systemBackground))
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    )
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Desserts")
            .task {
                do {
                    meals = try await apiService.fetchDesserts()
                } catch {
                    print("Error fetching meals: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

#Preview {
    MainView()
}
