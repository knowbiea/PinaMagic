//
//  MainView.swift
//  PinaMagic
//
//  Created by Arvind on 23/02/25.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    @EnvironmentObject var appCoordinator: AppFlowCoordinator
    private let appDIContainer: AppDIContainer
    
    // MARK: - Initializers
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    // MARK: - Content View
    var body: some View {
        Group {
            appDIContainer.makeUserListDIContainer()
                .makeUserListFlowCoordinator(navigationPath: $appCoordinator.path)
                .start()
        }
    }
}

#Preview {
    MainView(appDIContainer: AppDIContainer())
}
