//
//  DataService.swift
//  ConcurrentDispatchQueue
//
//  Created by Rob Kerr on 1/20/21.
//

import Foundation
import UIKit
import os

public class DataService {
    
    private enum Endpoint : String {
        case weather = "https://www.cuvenx.com/testdata/aaweather.json"
        case locationInfo = "https://www.cuvenx.com/testdata/aainfo.json"
    }
    
    class var sharedInstance:DataService {
        struct SingletonWrapper {
            static let singleton = DataService()
        }
        return SingletonWrapper.singleton
    }
    
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    let logger = Logger(subsystem: "com.cuvenx.concurrentdisptachqueue", category: "dataservice")
    
    // NOTE: this web request doesn't include error handling and shouldn't be used as-is for production purposes
    func fetchWeather(completion: @escaping (_ events: Weather?) -> Void)  {
        guard let url = URL(string: Endpoint.weather.rawValue) else {
            completion(nil)
             return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
      
        
        let task = self.session.dataTask(with: request) { (data, _, _) in
            if let jsonData = data {
                do {
                    let obj = try JSONDecoder().decode(Weather.self, from: jsonData)
                    self.logger.info("Weather API returns, sending data back to view model")
                    completion(obj)
                }
                catch {
                    self.logger.log(level: .error, "weather decode exception: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        
        logger.info("Fetching weather from API...")
        task.resume()
    }
    
    // NOTE: this web request doesn't include error handling and shouldn't be used as-is for production purposes
    func fetchLocationInfo(completion: @escaping (_ events: LocationInfo?) -> Void) {
        guard let url = URL(string: Endpoint.locationInfo.rawValue) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = self.session.dataTask(with: request) { (data, _, _) in
            if let jsonData = data {
                do {
                    let obj = try JSONDecoder().decode(LocationInfo.self, from: jsonData)
                    self.logger.info("Location info API returns, sending data back to view model (after 3 second delay)...")
                    DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                        self.logger.info("...location info 3 second delay expires, send data now")
                        completion(obj)
                    }
                    
                }
                catch {
                    self.logger.log(level: .error, "locationInfo decode exception: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        logger.info("Fetching location from API...")
        task.resume()
    }
    
    // NOTE: this web request doesn't include error handling and shouldn't be used as-is for production purposes
    func fetchImage(url: String?, completion: @escaping (_ image: UIImage?) -> Void) {
        guard let urlString = url, let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = self.session.dataTask(with: url) { (data, _, _) in
            if let imageData = data, let image = UIImage(data: imageData) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
}
