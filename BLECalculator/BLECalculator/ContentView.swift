//
//  ContentView.swift
//  BLECalculatorApp
//
//  Created by Rob Kerr on 8/7/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bleService = CalculatorViewModel()
    
    var body: some View {
        VStack {
            VStack {
            Text(bleService.output)
                .frame(width: 300, height: 50, alignment: .trailing)
                .font(.title)
                .background(Color.gray.opacity(0.2))
                .padding(.bottom)
            
            HStack {
                VStack(spacing: 10) {
                    HStack {
                        
                        Button("1") {
                            bleService.enterDigit(1)
                        }.buttonStyle(CalculatorButton())
                        
                        Button("2") {
                            bleService.enterDigit(2)
                        }.buttonStyle(CalculatorButton())
                        Button("3") {
                            bleService.enterDigit(3)
                        }.buttonStyle(CalculatorButton())
                    }
                    HStack {
                        Button("4") {
                            bleService.enterDigit(4)
                        }.buttonStyle(CalculatorButton())
                        Button("5") {
                            bleService.enterDigit(5)
                        }.buttonStyle(CalculatorButton())
                        Button("6") {
                            bleService.enterDigit(6)
                        }.buttonStyle(CalculatorButton())
                    }
                    HStack {
                        Button("7") {
                            bleService.enterDigit(7)
                        }.buttonStyle(CalculatorButton())
                        Button("8") {
                            bleService.enterDigit(8)
                        }.buttonStyle(CalculatorButton())
                        Button("9") {
                            bleService.enterDigit(9)
                        }.buttonStyle(CalculatorButton())
                    }
                }
                
                VStack (spacing: 10) {
                    Button("+") {
                        bleService.send(.add)
                    }
                    .buttonStyle(CalculatorButton(color: .blue.opacity(0.8)))
                    
                    Button("-") {
                        bleService.send(.subtract)
                    }
                    .buttonStyle(CalculatorButton(color: .blue.opacity(0.8)))
                    
                    Button("X") {
                        bleService.send(.multiply)
                    }
                    .buttonStyle(CalculatorButton(color: .blue.opacity(0.8)))
                }
            }
            }.opacity(bleService.connected ? 1.0 : 0.0)

            HStack {
            if bleService.connected {
                Button(action: {
                    bleService.disconnectCalculator()
                }, label: {
                    Text("Disconnect")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .padding()
                }).buttonStyle(ConnectButton())
            } else {
                Button(action: {
                    bleService.connectCalculator()
                }, label: {
                    Text("Connect")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .padding()
                }).buttonStyle(ConnectButton())
            }
            }
            .frame(width: 220)
            .padding(.top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
