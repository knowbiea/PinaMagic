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
    @AppStorage("likes") var likes: String = ""
    
    init(ingredient: Ingredient, listViewModel: any IngredientListViewModelType) {
        self.ingredient = ingredient
        self.listViewModel = listViewModel
    }
    
    func updateLike() {
        likes =  likes.contains(ingredient.id)
        ? likes.replacingOccurrences(of: "\(ingredient.id),", with: "")
        : likes + "\(ingredient.id),"
        
        ingredient.isLiked.toggle()
        listViewModel.updateLike(ingredient: ingredient)
    }
}
