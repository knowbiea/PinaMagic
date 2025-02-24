//
//  IngredientListDIContainer.swift
//  PinaMagic
//
//  Created by Arvind on 23/02/25.
//

import SwiftUI

final class IngredientListDIContainer {
    
    // MARK: - CoOrdinator
    func makeUserListFlowCoordinator(navigationPath: Binding<NavigationPath>) -> IngredientListFlowCoordinator {
        IngredientListFlowCoordinator(navigationPath: navigationPath,
                                      dependencies: self,
                                      page: .ingredientList)
    }
}

// MARK: - IngredientListFlowCoordinatorDependencies
extension IngredientListDIContainer: IngredientListFlowCoordinatorDependencies {
    
    func makeIngredientListViewModel(action: IngredientListViewActions) -> IngredientListViewModel {
        IngredientListViewModel(repository: makeIngredientRepository(), actions: action)
    }
    
    func makeIngredientRepository() -> IngredientRepositoryType {
        IngredientRepository(networkManager: makeNetworkManager())
    }
    
    func makeNetworkManager() -> NetworkManagerType {
        NetworkManager()
    }
    
    func makeIngredientDetailViewModel(Ingredient: Ingredient, listViewModel: any IngredientListViewModelType) -> IngredientDetailViewModel {
        IngredientDetailViewModel(ingredient: Ingredient, listViewModel: listViewModel)
    }
}

