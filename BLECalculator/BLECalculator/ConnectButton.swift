//
//  ConnectButton.swift
//  BLECalculatorApp
//
//  Created by Rob Kerr on 8/7/21.
//

import SwiftUI

struct ConnectButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 70, alignment: .center)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8.0)
    }
}

struct ConnectButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
        Button(action: {}) { Text("10") }
            .buttonStyle(ConnectButton())
        }
    }
}
