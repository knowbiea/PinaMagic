//
//  PinaMagicApp.swift
//  PinaMagic
//
//  Created by Arvind on 23/02/25.
//

import SwiftUI

@main
struct PinaMagicApp: App {
    // MARK: - Properties
    @StateObject private var appFlowCoordinator = AppFlowCoordinator(path: NavigationPath(),
                                                                     appDIContainer: AppDIContainer())
    
    // MARK: - View
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appFlowCoordinator.path) {
                appFlowCoordinator.start()
                    .navigationDestination(for: IngredientListFlowCoordinator.self) { coordinator in
                        coordinator.start()
                    }
            }
            .environmentObject(appFlowCoordinator)
        }
    }
}
