//
//  IngredientListView.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI

struct IngredientListView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: IngredientListViewModel

    // MARK: - View
    var body: some View {
        VStack {
            Picker("", selection: $viewModel.selectionType) {
                ForEach(IngredientType.allCases, id: \.self) { type in
                    Text(type.title)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal, 12)
            
            List(viewModel.filteredIngredients) { ingredient in
                IngredientRow(ingredient: ingredient)
                    .onTapGesture {
                        viewModel.goToUserDetailView(ingredient: ingredient)
                    }
            }
            .listStyle(.plain)
            .accessibilityLabel("ingredients_Lists")
        }
        .navigationTitle("All Cocktails")
        .onChange(of: viewModel.selectionType) { type in
            viewModel.filteredData(type)
        }
        .onAppear {
            guard !viewModel.hasAppeared else { return }
            viewModel.hasAppeared.toggle()
            viewModel.fetchIngredients()
            print("Configuration.environment.baseURL: \(Configuration.environment.baseURL)")
        }
    }
    
    struct IngredientRow: View {
        var ingredient: Ingredient
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                VStack {
                    Group {
                        HStack {
                            Text(ingredient.name)
                                .font(.bold16)
                                .foregroundStyle(ingredient.isLiked ? Color.purple : .black)
                                .accessibilityLabel(ingredient.name)
                            if ingredient.isLiked {
                                Spacer()
                                Image(systemName:"heart.fill")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.purple)
                            }
                        }
                        
                        Text(ingredient.shortDescription)
                            .font(.regular14)
                            .accessibilityLabel(ingredient.shortDescription)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
            }
            .listRowSeparator(.hidden)
            .accessibilityElement(children: .contain)
        }
    }
}

#Preview {
    let repository = IngredientRepository(networkManager: NetworkManager())
    let viewModel = IngredientListViewModel(repository: repository, actions: nil)
    IngredientListView(viewModel:viewModel)
}
