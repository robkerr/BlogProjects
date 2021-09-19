//
//  KeypadView.swift
//  BLECalculator
//
//  Created by Rob Kerr on 8/7/21.
//

import SwiftUI

struct KeypadView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    var body: some View {
        HStack {
            VStack(spacing: 10) {
                HStack {
                    
                    Button("1") {
                        viewModel.enterDigit(1)
                    }.buttonStyle(CalculatorButton())
                    
                    Button("2") {
                        viewModel.enterDigit(2)
                    }.buttonStyle(CalculatorButton())
                    Button("3") {
                        viewModel.enterDigit(3)
                    }.buttonStyle(CalculatorButton())
                }
                HStack {
                    Button("4") {
                        viewModel.enterDigit(4)
                    }.buttonStyle(CalculatorButton())
                    Button("5") {
                        viewModel.enterDigit(5)
                    }.buttonStyle(CalculatorButton())
                    Button("6") {
                        viewModel.enterDigit(6)
                    }.buttonStyle(CalculatorButton())
                }
                HStack {
                    Button("7") {
                        viewModel.enterDigit(7)
                    }.buttonStyle(CalculatorButton())
                    Button("8") {
                        viewModel.enterDigit(8)
                    }.buttonStyle(CalculatorButton())
                    Button("9") {
                        viewModel.enterDigit(9)
                    }.buttonStyle(CalculatorButton())
                }
            }
            
            VStack (spacing: 10) {
                Button("+") {
                    viewModel.send(.add)
                }
                .buttonStyle(CalculatorButton(color: .blue.opacity(0.8)))
                
                Button("-") {
                    viewModel.send(.subtract)
                }
                .buttonStyle(CalculatorButton(color: .blue.opacity(0.8)))
                
                Button("X") {
                    viewModel.send(.multiply)
                }
                .buttonStyle(CalculatorButton(color: .blue.opacity(0.8)))
            }
        }.opacity(viewModel.connected ? 1.0 : 0.0)
    }
}

struct KeypadView_Previews: PreviewProvider {
    static var viewModel = CalculatorViewModel()
    static var previews: some View {
        KeypadView(viewModel: viewModel)
    }
}
