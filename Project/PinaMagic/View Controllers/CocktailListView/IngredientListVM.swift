//
//  IngredientListVM.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI
import Combine

struct IngredientListViewActions {
    var goToIngredientDetailScreen: (Ingredient, any IngredientListViewModelType) -> Void
}

protocol IngredientListViewModelType {
    var filteredIngredients: [Ingredient] { get set }
    var selectionType: IngredientType { get set }
    var hasAppeared: Bool { get set }
    func fetchIngredients()
    func filteredData(_ type: IngredientType)
    func goToUserDetailView(ingredient: Ingredient)
    func updateLike(ingredient: Ingredient)
}

final class IngredientListViewModel: ObservableObject, IngredientListViewModelType {
    
    @Published var filteredIngredients: [Ingredient] = []
    @Published var selectionType: IngredientType = .all
    @Published var hasAppeared = false
    private var actions: IngredientListViewActions?
    private var ingredients: [Ingredient] = []
    private var repository: IngredientRepositoryType
    private var cancellable = Set<AnyCancellable>()
        
    init(repository: IngredientRepositoryType, actions: IngredientListViewActions?) {
        self.repository = repository
        self.actions = actions
    }
    
    func fetchIngredients() {
        repository.fetchIngredients()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.ingredients = value
                self.filteredIngredients = ingredients
            }
            .store(in: &cancellable)
    }
    
    func filteredData(_ type: IngredientType) {
        filteredIngredients = ingredients.filter { type == .all ? true : $0.type == type }
    }
    
    func goToUserDetailView(ingredient: Ingredient) {
        actions?.goToIngredientDetailScreen(ingredient, self)
    }
    
    func updateLike(ingredient: Ingredient) {
        if let index = filteredIngredients.firstIndex(where: { $0.id == ingredient.id }),
           let ingredientIndex = ingredients.firstIndex(where: { $0.id == ingredient.id }) {
            filteredIngredients[index].isLiked = ingredient.isLiked
            ingredients[ingredientIndex].isLiked = ingredient.isLiked
        }
    }
}
