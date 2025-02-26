//
//  IngredientListVMTests.swift
//  PinaMagic
//
//  Created by Arvind on 26/02/25.
//

import XCTest
import Combine
@testable import PinaMagic

final class IngredientListVMTests: XCTestCase {
 
    func test_FetchIngredients_Success() {
        let sut = createSutSuccess()
        XCTAssertTrue(sut.filteredIngredients.count > 0)
        XCTAssertEqual(sut.selectionType, .all)
    }
    
    func test_FetchIngredients_Failure() {
        let sut = createSut(data: nil, error: NetworkError.unknown)
        sut.fetchIngredients()
        
        XCTAssertEqual(sut.filteredIngredients.count, 0)
    }
    
    func test_IngredientListVM_UpdateLike() {
        let sut = createSutSuccess()
        
        sut.updateLike(ingredient: MockIngredient.ingredient)
        let ingredient = sut.filteredIngredients.first!
        
        XCTAssertTrue(sut.filteredIngredients.count > 0)
        XCTAssertEqual(sut.selectionType, .all)
        XCTAssertEqual(ingredient.name, "Mojito")
        XCTAssertEqual(ingredient.type, .alcoholic)
    }
    
    func test_IngredientListVM_FilteredData() {
        let sut = createSutSuccess()
        
        sut.filteredData(.alcoholic)
        let ingredient = sut.filteredIngredients.first!
        
        XCTAssertTrue(sut.filteredIngredients.count > 0)
        XCTAssertEqual(sut.selectionType, .all)
        XCTAssertEqual(ingredient.name, "Bloody Mary")
        XCTAssertEqual(ingredient.type, .alcoholic)
    }
    
    private func createSut(data: Data?, error: NetworkError?) -> IngredientListViewModel {
        let networkManager = MockNetworkManager()
        networkManager.data = data
        networkManager.error = error
        let repository = MockIngredientRepository(networkManager: networkManager)
        return IngredientListViewModel(repository: repository, actions: nil)
    }
    
    private func createSutSuccess() -> IngredientListViewModel {
        let path = Bundle.main.path(forResource: "sample", ofType: "json") ?? ""
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let sut = createSut(data: data, error: nil)
        
        let expectation = XCTestExpectation(description: "Fetch ingredients completes")
        sut.fetchIngredients()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        return sut
    }
}
