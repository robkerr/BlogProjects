//
//  CalculatorButton.swift
//  BLECalculatorApp
//
//  Created by Rob Kerr on 8/7/21.
//

import SwiftUI

struct CalculatorButton: ButtonStyle {
    let height:CGFloat
    let color:Color
    
    init(height: CGFloat = 70, color: Color = .orange) {
        self.height = height
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: height, alignment: .center)
            .background(color)
            .foregroundColor(.white)
            .font(.title)
            .cornerRadius(8.0)

    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) { Text("10") }
            .buttonStyle(CalculatorButton(height: 150))
    }
}
