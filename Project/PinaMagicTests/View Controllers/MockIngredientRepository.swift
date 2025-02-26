//
//  MockIngredientRepository.swift
//  PinaMagic
//
//  Created by Arvind on 26/02/25.
//

import XCTest
import Combine
@testable import PinaMagic

final class MockIngredientRepository: IngredientRepositoryType {
    
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func fetchIngredients() -> AnyPublisher<[Ingredient], NetworkError> {
        networkManager.apiModelRequest([Ingredient].self, .bundle("custom")).eraseToAnyPublisher()
    }
}
