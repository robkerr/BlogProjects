//
//  LocationViewModel.swift
//  ConcurrentDispatchQueue
//
//  Created by Rob Kerr on 1/20/21.
//

import Foundation

class EventViewModel : Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var locationInfo: LocationInfo?
    
    func fetchEvents() {
        
        DataService.sharedInstance.fetchWeather { [weak self] (weather) in
            if let weather = weather, let self = self {
                
            }
        }
        
        DataService.sharedInstance.fetchLocationInfo { [weak self] (locInfo) in
            if let locInfo = locInfo, let self = self {
                
            }
        }
        
    }
}
