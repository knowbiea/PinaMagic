//
//  AppFlowCoordinator.swift
//  PinaMagic
//
//  Created by Arvind on 23/02/25.
//

import SwiftUI

final class AppFlowCoordinator: ObservableObject {
    
    // MARK: - Properties
    @Published var path: NavigationPath
    private let appDIContainer: AppDIContainer

    // MARK: - Initializers
    init(path: NavigationPath, appDIContainer: AppDIContainer) {
        self.path = path
        self.appDIContainer = appDIContainer
    }

    @ViewBuilder
    func start() -> some View {
        MainView(appDIContainer: appDIContainer)
    }
}
