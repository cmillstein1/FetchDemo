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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let mealDetails = mealDetail {
                        AsyncImage(url: URL(string: mealDetails.strMealThumb)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                                .cornerRadius(15)
                                .shadow(radius: 10)
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]), startPoint: .bottom, endPoint: .center)
                                )
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        Text(mealDetails.strMeal)
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .bold()
                            .padding(.top)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack(spacing: 8) {
                            Text("Ingredients")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 5)
                            
                            
                            ForEach(mealDetails.ingredients, id: \.self) { ingredient in
                                
                                Text("• \(ingredient)")
                                    .font(.body)
                                    .padding(.leading, 8)
                                    .padding(.bottom, 2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Instructions")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 5)
                            
                            ForEach(formatInstructions(mealDetails.strInstructions), id: \.self) { instruction in
                                
                                Text("• \(instruction)")
                                    .font(.body)
                                    .padding(.leading, 8)
                                    .padding(.bottom, 2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                    } else {
                        VStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5)
                                .padding(.top, 50)
                            
                            Text("Loading Details...")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding(.top, 10)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
                .padding([.leading, .trailing])
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: customBackButton)
        }
        .task {
            await fetchDessertDetails()
        }
    }
    
    private func fetchDessertDetails() async {
        do {
            mealDetail = try await apiService.fetchMealDetails(id: mealId)
        } catch {
            print("Error fetching meal details: \(error.localizedDescription)")
        }
    }
    
    private func formatInstructions(_ instructions: String) -> [String] {
        instructions.components(separatedBy: ". ")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter { !$0.isEmpty }
    }
    
    private var customBackButton : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack{
                Image(systemName: "chevron.backward.circle")
                    .foregroundColor(.black)
                Text("Back")
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    MealDetailView(mealId: "52897")
}
