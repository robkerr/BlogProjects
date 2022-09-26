//
//  ContentView.swift
//  BackwardsCompatibleModifier
//
//  Created by Rob Kerr on 9/20/22.
//

import SwiftUI

struct ClearListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

extension View {
    func clearListBackground() -> some View {
        modifier(ClearListBackgroundModifier())
    }
}

struct ContentView: View {
    
    init() {
        if #unavailable(iOS 16.0) {
            print("### setting backgroundColor to .clear")
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Text("Title here")
                    .font(.title)
                
                List(1...10, id: \.self) { i in
                    Text("List Item \(i)")
                }
                .clearListBackground()
                
                Button(action: {}) {
                    Text("Do Something")
                }
                    .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
