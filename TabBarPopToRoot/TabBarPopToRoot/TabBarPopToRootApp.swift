//
//  TabBarPopToRootApp.swift
//  TabBarPopToRoot
//
//  Created by Rob Kerr on 11/28/21.
//

import SwiftUI

@main
struct TabBarPopToRootApp: App {
    @ObservedObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(appState)
        }
    }
}
