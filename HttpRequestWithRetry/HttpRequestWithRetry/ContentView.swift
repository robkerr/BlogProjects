//
//  ContentView.swift
//  HttpRequestWithRetry
//
//  Created by Rob Kerr on 1/28/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var endpoint = Endpoint.valid
    
    var body: some View {
        ZStack {
            VStack {
                Picker("", selection: $endpoint) {
                    Text("Ann Arbor").tag(Endpoint.valid)
                    Text("Invalid City").tag(Endpoint.invalid)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Network Fetch") {
                    viewModel.fetchWeather(endpoint: endpoint)
                }
                
                if let temp = viewModel.temperature {
                    Text("Temperature: \(temp)")
                        .padding()
                }
                
                if let errMessage = viewModel.error {
                    Text("Error: \(errMessage)")
                        .padding()
                }
            }
        }
        
        ProgressView("Loading...")
            .font(.title2)
            .opacity(viewModel.networkRequestInProcess ? 1.0 : 0).animation(.linear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var viewModel = ContentViewModel()
    
    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
