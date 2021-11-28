//
//  RootContentView.swift
//  TabBarPopToRoot
//
//  Created by Rob Kerr on 11/28/21.
//

import SwiftUI

struct RootContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Root is level 1")
            NavigationLink(destination: ChildView(level: 2)) {
                Text("Click to launch a child")
            }
        }
    }
}
