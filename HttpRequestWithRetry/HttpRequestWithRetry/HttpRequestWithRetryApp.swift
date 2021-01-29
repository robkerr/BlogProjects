//
//  HttpRequestWithRetryApp.swift
//  HttpRequestWithRetry
//
//  Created by Rob Kerr on 1/28/21.
//

import SwiftUI

@main
struct HttpRequestWithRetryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
