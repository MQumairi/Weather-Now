//
//  WeatherModel.swift
//  Weather Now
//
//  Created by Mohammed Alqumairi on 12/21/19.
//  Copyright © 2019 Mohammed Alqumairi. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let conditionID : Int
    let description : String
    let temperature : Double
    let cityName : String
    
    
    var tempString : String {
        
        return "\(Int(round(temperature)))°C"

    }
    
    var conditionName : String {
        
        switch conditionID {
        case 200...232 :
            return "cloud.bolt"
            
        case 300...321 :
            return "cloud.drizzle"
            
        case 500...531 :
            return "cloud.heavyrain"
            
        case 600...622 :
            return "snow"
            
        case 701...781 :
            return "cloud.fog"
            
        case 781 :
            return "tornado"
            
        case 800 :
            return "sun.max"
            
        case 801...804 :
            return "cloud"
            
        default :
            return "cloud"
        }
    }
    
}
