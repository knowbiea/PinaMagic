//
//  IngredientDetailVMTests.swift
//  PinaMagic
//
//  Created by Arvind on 26/02/25.
//

import XCTest
import Combine
@testable import PinaMagic

final class IngredientDetailVMTests: XCTestCase {
    
    func test_IngredientListVM_FilteredData() {
        let ingredient = Ingredient(id: "1",
                                    name: "Mojito",
                                    type: .alcoholic,
                                    shortDescription: "A refreshing Cuban classic made with white rum and muddled fresh mint.",
                                    longDescription: "This is an authentic recipe for mojito. I sized the recipe for one serving, but you can adjust it accordingly and make a pitcher full. It's a very refreshing drink for hot summer days. Be careful when drinking it, however. If you make a pitcher you might be tempted to drink the whole thing yourself, and you just might find yourself talking Spanish in no time! Tonic water can be substituted instead of the soda water but the taste is different and somewhat bitter.",
                                    preparationMinutes: 5,
                                    imageName: "Sample",
                                    image: "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg",
                                    ingredients: ["1 measure pineapple juice",
                                                  "1 measure orange juice",
                                                  "1 measure freshly squeeze lime juice"],
                                    isLiked: false)
        
        let listVM = createSutSuccess()
        let sut = createSut(ingredient: ingredient, viewModel: listVM)
        sut.updateLike()
        let firstIngredient = listVM.filteredIngredients.first!
        
        XCTAssertTrue(listVM.filteredIngredients.count > 0)
        XCTAssertEqual(firstIngredient.name, "Mojito")
        XCTAssertEqual(firstIngredient.type, .alcoholic)
    }
    
    private func createSut(ingredient: Ingredient, viewModel: IngredientListViewModelType) -> IngredientDetailViewModel {
        return IngredientDetailViewModel(ingredient: ingredient, listViewModel: viewModel)
    }
    
    private func createSutSuccess() -> IngredientListViewModel {
        let path = Bundle.main.path(forResource: "sample", ofType: "json") ?? ""
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)

        let networkManager = MockNetworkManager()
        networkManager.data = data
        let repository = MockIngredientRepository(networkManager: networkManager)
        let sut = IngredientListViewModel(repository: repository, actions: nil)
        
        let expectation = XCTestExpectation(description: "Fetch ingredients completes")
        sut.fetchIngredients()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        return sut
    }
}
