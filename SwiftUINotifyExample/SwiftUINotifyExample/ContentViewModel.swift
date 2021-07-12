//
//  ContentViewModel.swift
//  SwiftUINotifyExample
//
//  Created by Rob Kerr on 7/11/21.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var changingColor = Color.blue
    @Published var rotationAngle = 0.0
    @Published var largeSize = true
    private var changeSizeMessageObserver:NSObjectProtocol?
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.changingColor = self.randomColor()
            self.rotationAngle = self.changingColor.cgColor!.components![0] * 360.0
        })
        
        changeSizeMessageObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: DataService.notificationName),
            object: nil, queue: nil) {_ in
                withAnimation {
                    self.largeSize.toggle()
                }
        }
    }
    
    deinit {
        if let obs = changeSizeMessageObserver {
            print("Removing observer")
            NotificationCenter.default.removeObserver(obs)
        }
    }
    
    private func randomColor() -> Color {
        return Color(red: Double.random(in: 0.0...1.0),
                    green: Double.random(in: 0.0...1.0),
                      blue: Double.random(in: 0.0...1.0))
    }
}
