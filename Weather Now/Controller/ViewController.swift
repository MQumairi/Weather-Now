//
//  ViewController.swift
//  Weather Now
//
//  Created by Mohammed Alqumairi on 12/21/19.
//  Copyright © 2019 Mohammed Alqumairi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var weatherManger = WeatherManager()
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        weatherManger.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @IBAction func findLocationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchCityButtonPressed(_ sender: UIButton) {
        
        if let cityName = searchBar.text {
            
            weatherManger.apiCall(cityName: cityName)
            
        }
        
        searchBar.endEditing(true)
    }
}




extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if let cityName = searchBar.text {
            
            weatherManger.apiCall(cityName: cityName)
            
        }
        
        searchBar.endEditing(true)
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBar.text = ""
    }
}


extension ViewController: WeatherManagerDelegate {
    
    func requestNewWeatherData(_ weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.weatherIcon.image = UIImage(systemName: weather.conditionName)
            self.locationLabel.text = (weather.cityName).capitalized
            self.descriptionLabel.text = (weather.description).capitalized
            self.temperatureLabel.text = weather.tempString
        }
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManger.apiCall(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

