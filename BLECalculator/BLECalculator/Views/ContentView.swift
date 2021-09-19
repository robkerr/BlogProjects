//
//  ContentView.swift
//  BLECalculatorApp
//
//  Created by Rob Kerr on 8/7/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some View {
        VStack {
            VStack {
                
            Text(viewModel.output)
                .frame(width: 300, height: 50, alignment: .trailing)
                .font(.title)
                .background(Color.gray.opacity(0.2))
                .padding(.bottom)
 
            KeypadView(viewModel: viewModel)
            ConnectButtonView(viewModel: viewModel)
            
        }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
