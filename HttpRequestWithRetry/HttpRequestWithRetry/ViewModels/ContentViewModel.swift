//
//  ContentViewModel.swift
//  HttpRequestWithRetry
//
//  Created by Rob Kerr on 1/28/21.
//

import Foundation

enum Endpoint : String {
    case valid = "https://www.cuvenx.com/testdata/aaweather.json"
    case invalid = "https://www.cuvenx.com/invalidpath.html"
}

class ContentViewModel : Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var networkRequestInProcess = false
    @Published var temperature: Double? = nil
    @Published var error: String? = nil
    
    func fetchWeather(endpoint: Endpoint) {
        self.networkRequestInProcess = true
        //NetworkClient.sharedInstance.fetchWithoutRetry(url: endpoint.rawValue) { [weak self] (weather, error) in
        NetworkClient.sharedInstance.fetchWithRetry(url: endpoint.rawValue) { [weak self] (weather, error) in
            if let self = self {
                DispatchQueue.main.async {
                    self.networkRequestInProcess = false
                    self.temperature = weather?.temp
                    self.error = error
                }
            }
        }
    }
}
