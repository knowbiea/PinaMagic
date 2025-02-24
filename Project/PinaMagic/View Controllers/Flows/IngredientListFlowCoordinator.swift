//
//  IngredientListFlowCoordinator.swift
//  PinaMagic
//
//  Created by Arvind on 23/02/25.
//

import SwiftUI

enum IngredientListPage {
    case ingredientList, ingredientDetail(Ingredient, listViewModel: any IngredientListViewModelType)
}

final class IngredientListFlowCoordinator: Hashable {
    
    // MARK: - Properties
    @Binding var navigationPath: NavigationPath
    var dependencies: IngredientListFlowCoordinatorDependencies
    
    private var id: UUID
    private var page: IngredientListPage
    
    init(navigationPath: Binding<NavigationPath>,
         dependencies: IngredientListFlowCoordinatorDependencies,
         page: IngredientListPage) {
        self.id = UUID()
        self._navigationPath = navigationPath
        self.dependencies = dependencies
        self.page = page
    }
    
    static func == (lhs: IngredientListFlowCoordinator, rhs: IngredientListFlowCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Views
    @ViewBuilder
    func start() -> some View {
        switch self.page {
        case .ingredientList: loginView()
        case .ingredientDetail(let ingredient, let viewModel): userDetailView(ingredient: ingredient, listViewModel: viewModel)
        }
    }
    
    private func loginView() -> some View {
        let actions = IngredientListViewActions(goToIngredientDetailScreen: goToIngredientDetailScreen)
        return IngredientListView(viewModel: self.dependencies.makeIngredientListViewModel(action: actions))
    }
    
    func goToIngredientDetailScreen(ingredient: Ingredient, listViewModel: any IngredientListViewModelType) {
        navigationPath.append(IngredientListFlowCoordinator(navigationPath: $navigationPath,
                                                            dependencies: dependencies,
                                                            page: .ingredientDetail(ingredient, listViewModel: listViewModel)))
    }
    
    private func userDetailView(ingredient: Ingredient, listViewModel: any IngredientListViewModelType) -> some View {
        return IngredientDetailView(viewModel: self.dependencies.makeIngredientDetailViewModel(Ingredient: ingredient, listViewModel: listViewModel))
    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}

protocol IngredientListFlowCoordinatorDependencies  {
    func makeIngredientListViewModel(action: IngredientListViewActions) -> IngredientListViewModel
    func makeIngredientDetailViewModel(Ingredient: Ingredient, listViewModel: any IngredientListViewModelType) -> IngredientDetailViewModel
}

