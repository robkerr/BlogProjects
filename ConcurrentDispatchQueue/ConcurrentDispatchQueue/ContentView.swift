//
//  ContentView.swift
//  ConcurrentDispatchQueue
//
//  Created by Rob Kerr on 1/20/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: LocationViewModel
    
    var columns =
        [
            GridItem(.flexible(), alignment: .leading),
            GridItem(.flexible(), alignment: .leading)
        ]
    
    var body: some View {
        ZStack {
            VStack {
                GroupBox {
                LazyVGrid(columns: columns, spacing: 20) {
                    Text("City Name")
                    Text("\(viewModel.locationInfo?.weather?.name ?? "")")
                        .fontWeight(.bold)
                    
                    Text("Population")
                    Text("\(viewModel.locationInfo?.population ?? 0)")
                        .fontWeight(.bold)
                    
                    Text("Current Temp")
                    Text("\(viewModel.locationInfo?.weather?.temp ?? 0)")
                        .fontWeight(.bold)
                }
                }.colorInvert().opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
            .background(
                Image(uiImage: viewModel.locationImage ?? UIImage())
                    .opacity(0.7)
            )
            .padding()
            .opacity(viewModel.locationInfo == nil ? 0 : 1)
            
            ProgressView("API Request in Progress...")
                .opacity(viewModel.locationInfo == nil ? 1 : 0)
        }
        .onAppear {
            viewModel.fetchDataFromApi()
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var viewModel = LocationViewModel()
    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
