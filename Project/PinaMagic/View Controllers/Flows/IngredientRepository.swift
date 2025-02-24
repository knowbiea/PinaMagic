//
//  IngredientRepository.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI
import Combine

protocol IngredientRepositoryType {
    func fetchIngredients() -> AnyPublisher<[Ingredient], NetworkError>
}

final class IngredientRepository: IngredientRepositoryType {
    
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func fetchIngredients() -> AnyPublisher<[Ingredient], NetworkError> {
        networkManager.apiModelRequest([Ingredient].self, .bundle("sample"))
            .eraseToAnyPublisher()
    }
}
