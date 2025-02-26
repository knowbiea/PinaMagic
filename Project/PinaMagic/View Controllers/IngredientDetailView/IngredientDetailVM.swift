//
//  IngredientDetailVM.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI
import Combine

protocol IngredientDetailViewModelType {
    var ingredient: Ingredient { get set }
    func updateLike()
}

class IngredientDetailViewModel: ObservableObject, IngredientDetailViewModelType {
    @Published var ingredient: Ingredient
    var listViewModel: any IngredientListViewModelType
    
    init(ingredient: Ingredient, listViewModel: any IngredientListViewModelType) {
        self.ingredient = ingredient
        self.listViewModel = listViewModel
    }
    
    func updateLike() {
        ingredient.isLiked.toggle()
        listViewModel.updateLike(ingredient: ingredient)
    }
}
