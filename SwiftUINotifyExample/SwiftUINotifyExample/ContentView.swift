//
//  ContentView.swift
//  SwiftUINotifyExample
//
//  Created by Rob Kerr on 7/11/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var degrees = 0.0
    
    var body: some View {
        GeometryReader { geom in
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(viewModel.buttonColor)
                .frame(width: viewModel.largeSize ? 200 : 100,
                       height: viewModel.largeSize ? 100 : 50)
                .rotationEffect(Angle.degrees(degrees))
                .onChange(of: viewModel.rotationAngle) { newValue in
                    withAnimation {
                        if geom.size.width > 300 {
                            degrees = newValue
                        } else {
                            degrees = newValue - 20.0
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
