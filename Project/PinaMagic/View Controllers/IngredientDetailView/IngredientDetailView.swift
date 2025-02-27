//
//  IngredientDetailView.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI

struct IngredientDetailView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: IngredientDetailViewModel
    
    // MARK: - View
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack{
                        Image(systemName: "clock")
                            .frame(width: 16, height: 16)
                        Text("\(viewModel.ingredient.preparationMinutes ?? 0) minutes")
                            .font(.regular14)
                    }
                }
                .padding()
                
                Image(.sample)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 280)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.ingredient.longDescription)
                        .font(.regular16)
                    
                    Text("Ingredients")
                        .font(.semiBold25)
                        .padding(.bottom, 5)
                    
                    ForEach(viewModel.ingredient.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .font(.regular14)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: viewModel.ingredient.isLiked
                          ? "heart.fill"
                          : "heart")
                    .renderingMode(.template)
                    .foregroundStyle(viewModel.ingredient.isLiked
                                     ? Color.purple
                                     : .black)
                    .onTapGesture {
                        viewModel.updateLike()
                    }
                }
            }
        }
        .navigationTitle(viewModel.ingredient.name)
    }
}

#Preview {
    let ingredient = Ingredient(id: "123",
                            name: "Sample",
                            type: .alcoholic,
                            shortDescription: "Short Description",
                            longDescription: "Long Description",
                            preparationMinutes: 5,
                            imageName: "Sample",
                            image: "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg",
                            ingredients: ["1 measure pineapple juice",
                                          "1 measure orange juice",
                                          "1 measure freshly squeeze lime juice"],
                            isLiked: false)
    let repository = IngredientRepository(networkManager: NetworkManager())
    let viewModel = IngredientListViewModel(repository: repository, actions: nil)
    IngredientDetailView(viewModel: IngredientDetailViewModel(ingredient: ingredient,
                                                              listViewModel: viewModel))
}
