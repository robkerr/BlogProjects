//
//  ContentView.swift
//  TabBarPopToRoot
//
//  Created by Rob Kerr on 11/28/21.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            NavigationView {
                RootContentView()
                .id(appState.rootViewId)  // change to .id triggers popToRootView
            }.tabItem {
                Text("Tab1")
            }

            Text("Some other tab content").tabItem {
                Text("Tab 2")
            }

            Text("Some other tab content").tabItem {
                Text("Tab 2")
            }
        }
    }
}
