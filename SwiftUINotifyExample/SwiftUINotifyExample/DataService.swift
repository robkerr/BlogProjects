//
//  DataService.swift
//  SwiftUINotifyExample
//
//  Created by Rob Kerr on 7/11/21.
//

import Foundation

class DataService {
    static let notificationName = "CHANGE_SIZE"
    
    class var sharedInstance:DataService {
        struct SingletonWrapper {
            static let singleton = DataService()
        }
        return SingletonWrapper.singleton
    }
    
    func startService() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: DataService.notificationName), object: nil)
        })
    }
}
