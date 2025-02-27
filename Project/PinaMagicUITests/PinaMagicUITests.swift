//
//  PinaMagicUITests.swift
//  PinaMagicUITests
//
//  Created by Arvind on 23/02/25.
//

import XCTest
@testable import PinaMagic

class IngredientListViewTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testNavigationTitle() {
        let navigationBar = app.navigationBars["All Cocktails"]
        XCTAssertTrue(navigationBar.exists)
    }
    
    func testSegmentedControl() {
        let segmentedControl = app.segmentedControls.firstMatch
        XCTAssertTrue(segmentedControl.exists)
        XCTAssertEqual(segmentedControl.buttons.count, 3)
    }
    
    func testSegmentedControlSelection() {
        let segmentedControl = app.segmentedControls.firstMatch
        let secondSegment = segmentedControl.buttons.element(boundBy: 1)
        secondSegment.tap()
    }
    
    func testIngredientList() {
        let collectionView = app.collectionViews["ingredients_Lists"]
        XCTAssertTrue(collectionView.exists)
        let cell = collectionView.firstMatch
        cell.tap()
    }
    
    func testIngredientListCells() {
        let collectionView = app.collectionViews["ingredients_Lists"].firstMatch
        XCTAssertTrue(collectionView.exists)
        
        let cells = collectionView.cells
        XCTAssertTrue(cells.count > 0)
        
        for i in 0..<cells.count {
            let cell = cells.element(boundBy: i)
            let name = cell.staticTexts.firstMatch
            let description = cell.staticTexts.element(boundBy: 1)
            XCTAssertTrue(name.exists)
            XCTAssertTrue(description.exists)
        }
    }
}
