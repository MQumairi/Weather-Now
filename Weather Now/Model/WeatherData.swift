//
//  WeatherData.swift
//  Weather Now
//
//  Created by Mohammed Alqumairi on 12/21/19.
//  Copyright © 2019 Mohammed Alqumairi. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var name : String
    var timezone : Int
    var main : Main
    var weather : [Weather]
}

struct Main: Decodable {
    var temp : Double
}

struct Weather: Decodable {
    var description: String
    var id: Int
}
