//
//  AppDIContainer.swift
//  PinaMagic
//
//  Created by Arvind on 23/02/25.
//

import SwiftUI

final class AppDIContainer {
    
    // MARK: - DIContainers
    func makeUserListDIContainer() -> IngredientListDIContainer {
        return IngredientListDIContainer()
    }
}
