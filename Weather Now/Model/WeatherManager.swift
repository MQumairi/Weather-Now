//
//  WeatherManager.swift
//  Weather Now
//
//  Created by Mohammed Alqumairi on 12/21/19.
//  Copyright © 2019 Mohammed Alqumairi. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func requestNewWeatherData(_ weather: WeatherModel)
}

struct WeatherManager {
    let weatherManagerURL =  "https://api.openweathermap.org/data/2.5/weather?appid=cb1b7c1790ce526ab5f4234cb84f3c84&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func apiCall(cityName : String) {
        
        let calledURL = "\(weatherManagerURL)&q=\(cityName)"
                
        requestData(urlString: calledURL)
        
    }
    
    func apiCall (latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let calledURL = "\(weatherManagerURL)&lat=\(latitude)&lon=\(longitude)"
        requestData(urlString: calledURL)
    }
    
    func requestData(urlString : String) {
        
        if let url = URL(string: urlString) {
                        
            let session = URLSession(configuration: .default)
            
            print("Starting search...")
            
            let task = session.dataTask(with: url, completionHandler: {
                
                (data, response, error) in
                
                if(error != nil) {
                    print(error!.localizedDescription)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(data: safeData) {
                        self.delegate?.requestNewWeatherData(weather)
                    }
                    
                }
            })
            
            task.resume()
        }
    }
    
    
    func parseJSON (data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            print("Name: \(decodedData.name), Timezone: \(decodedData.timezone), Temperature: \(decodedData.main.temp), Description: \(decodedData.weather[0].description),")
            
            let weatherModel = WeatherModel(conditionID: decodedData.weather[0].id, description: decodedData.weather[0].description, temperature: decodedData.main.temp, cityName: decodedData.name)
            
            return weatherModel
            
        } catch {
            print(error)
            return nil
        }
        
    }
    
    
}
