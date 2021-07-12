//
//  SwiftUINotifyExampleApp.swift
//  SwiftUINotifyExample
//
//  Created by Rob Kerr on 7/11/21.
//

import SwiftUI

@main
struct SwiftUINotifyExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        DataService.sharedInstance.startService()
    }
}
