//
//  LocationViewModel.swift
//  ConcurrentDispatchQueue
//
//  Created by Rob Kerr on 1/20/21.
//

import UIKit
import os

class LocationViewModel : Identifiable, ObservableObject {
    var id = UUID()
    
    let concurrentQueue = DispatchQueue(label: "com.cuvenx.fetchqueue", attributes: .concurrent)
    let concurrentFetchGroup = DispatchGroup()
    let logger = Logger(subsystem: "com.cuvenx.concurrentdisptachqueue", category: "locationviewmodel")
    
    @Published var locationInfo: LocationInfo?
    @Published var locationImage: UIImage?
    
    func fetchDataFromApi() {
        var weatherData: Weather?
        var locationData: LocationInfo?
        

        // Dispatch the weather API fetch to the background thread queue
        concurrentFetchGroup.enter()
        self.concurrentQueue.async {
            self.logger.info("Dispatch fetchWeather from View Model")
            DataService.sharedInstance.fetchWeather { [weak self] (response) in
                weatherData = response
                self?.concurrentFetchGroup.leave()
            }
        }
        
        // Dispatch the location API fetch to the background thread queue
        concurrentFetchGroup.enter()
        self.concurrentQueue.async {
            self.logger.info("Dispatch fetchLocationInfo from View Model")
            DataService.sharedInstance.fetchLocationInfo { [weak self] (response) in
                locationData = response
                DataService.sharedInstance.fetchImage(url: response?.imageUrl) { [weak self] image in
                    DispatchQueue.main.async {
                        self?.locationImage = image
                    }
                    self?.concurrentFetchGroup.leave()
                }
            }
        }
        
        // Provide a block to execute when both API requests have completed
        //concurrentFetchGroup.notify(queue: DispatchQueue.global(qos: .background)) {
        concurrentFetchGroup.notify(queue: DispatchQueue.main) {
            self.logger.info("All API requests completed. Updating data model for UI refresh")
            if var locData = locationData {
                locData.weather = weatherData
                // Assigning this observable will trigger a UI update
                self.locationInfo = locData
            }
        }
    }
}
