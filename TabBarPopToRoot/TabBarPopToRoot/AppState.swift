//
//  AppState.swift
//  TabBarPopToRoot
//
//  Created by Rob Kerr on 11/28/21.
//

import SwiftUI

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
}

