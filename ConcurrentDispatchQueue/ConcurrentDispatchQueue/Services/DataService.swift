//
//  DataService.swift
//  ConcurrentDispatchQueue
//
//  Created by Rob Kerr on 1/20/21.
//

import Foundation
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
    
    let logger = Logger(subsystem: "com.cuvenx.concurrentdisptachqueue", category: "dataservice")
    
    func fetchWeather(completion: @escaping (_ events: [Weather]?) -> Void) {
        do {
            if let jsonData = "".data(using: .utf8) {
                let weather = try JSONDecoder().decode([Weather].self, from: jsonData)
                completion(weather)
            }
        } catch {
            logger.log(level: .error, "weather fetch exception: \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    func fetchLocationInfo(completion: @escaping (_ events: [LocationInfo]?) -> Void) {
        do {
            if let jsonData = "".data(using: .utf8) {
                let locationInfo = try JSONDecoder().decode([LocationInfo].self, from: jsonData)
                completion(locationInfo)
            }
        } catch {
            logger.log(level: .error, "weather fetch exception: \(error.localizedDescription)")
            completion(nil)
        }
    }
}
