//
//  main.swift
//  NestedAPIAwaitRefactor
//
//  Created by Rob Kerr on 7/13/21.
//

import Foundation

// Current weather - subset of properties returned from Dark Sky API
struct Currently : Decodable {
    let summary: String
    let temperature: Double
    let humidity: Double
    
    func sentence(_ cityName: String) -> String {
        return "Current weather in \(cityName): \(summary), Temp=\(round(temperature))º, Humidity=\(round(humidity * 100.0))"
    }
}

// Weather object - top level JSON object from Dark Sky (most properties ignored)
struct Weather : Decodable {
    let currently: Currently
}

// City objects returned from Azure API
struct City: Decodable {
    let name: String
    let airport: String
    let lat: Double
    let lon: Double
}

// DispatchGroup used to avoid the console app exiting before async work has completed
let dispatchGroup = DispatchGroup()

let decoder = JSONDecoder()
let cityUrl = URL(string: "https://robkerrblog.blob.core.windows.net/data/cities.json")!

// Place your API key here
let darkSkyKey = "*********************"
let darkSkyUrl = "https://api.darksky.net/forecast"

// This routine uses API calls and closures
func fetchWeatherWithClosures(cityName: String, completion: @escaping (Currently?) -> Void) {
    let cityTask = URLSession.shared.dataTask(with: URLRequest(url: cityUrl)) { data, response, error in
        if let data = data {
            if let cities = try? decoder.decode([City].self, from: data),
                 let city = cities.first(where: {$0.name == cityName}) {
                    let darkSkyUrl = URL(string: "\(darkSkyUrl)/\(darkSkyKey)/\(city.lat),\(city.lon)")!
                    
                    let weatherTask = URLSession.shared.dataTask(with: URLRequest(url: darkSkyUrl)) { data, response, error in
                            if let data = data {
                                if let weather = try? decoder.decode(Weather.self, from: data) {
                                    completion(weather.currently)
                                } else {
                                    completion(nil)
                                }
                            } else {
                                completion(nil)
                            }
                    }
                    weatherTask.resume()
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    cityTask.resume()
}

// The version that uses async/await
func fetchWeatherWithAwait(cityName: String) async throws -> Currently? {

    // Fetch City list from Azure API
    let (data, _) = try await URLSession.shared.data(for: URLRequest(url: cityUrl))

    if let cities = try? decoder.decode([City].self, from: data),
       let city = cities.first(where: {$0.name == cityName}) {

        // Fetch Weather from Dark Sky API
        let darkSkyUrl = URL(string: "\(darkSkyUrl)/\(darkSkyKey)/\(city.lat),\(city.lon)")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: darkSkyUrl))

        return (try? decoder.decode(Weather.self, from: data))?.currently
    }

    return nil
}


// Mainline of app. Supported city name on command line (Ann Arbor, Houghton, Seattle, Paris)
// This main line will run both versions (Closure and Async/Await). Each outputs the result to stdout
if CommandLine.arguments.count < 2 {
    print("Usage: NestedAPIAwaitRefactor \"<city name>\"")
} else {
    let cityName = CommandLine.arguments[1]
    
    //======= This is the closure version of the application (before refactor)  =======
    dispatchGroup.enter()
    fetchWeatherWithClosures(cityName: cityName) { currentWeather in
        if let weather = currentWeather {
            print("=== closure " + weather.sentence(cityName))
        } else {
            print("Error fetching weather!")
        }
        dispatchGroup.leave()
    }
    
    //======= This is the async/await version of the application (after refactor)  =======
    dispatchGroup.enter()
    Task {
        if let weather = try await fetchWeatherWithAwait(cityName: cityName) {
            print("=== async/await " + weather.sentence(cityName))
        } else {
            print("Error fetching weather!")
        }
        dispatchGroup.leave()
    }
        
    dispatchGroup.notify(queue: DispatchQueue.main) {
        // This block called when both versions of the app have completed
        exit(EXIT_SUCCESS)
    }
    dispatchMain()
}
