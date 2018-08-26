//
//  HomeViewModel.swift
//  Forecast
//
//  Created by Cole Roberts on 8/22/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import Foundation
import CoreLocation
import ForecastIO

class HomeViewModel {
    
    // MARK: - Properties
    
    let forecast = DarkSkyClient(apiKey: "b6e4edcb31a89fe6409e93e4aaaf6ac1")
    let geocoder: CLGeocoder = CLGeocoder()
    let locationManager: CLLocationManager = CLLocationManager()
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    let notificationCenter: NotificationCenter = NotificationCenter.default
    
    var isLiteMode: Bool = true
    
    // MARK: - Public methods
    
    public func getIcon(_ icon: Icon) -> UIImage {
        
        var iconName: String?
        
        switch(icon) {
        case .clearDay:
            iconName = Icons.clearDay
        
        case .clearNight:
            iconName = Icons.clearDay
        
        case .rain:
            iconName = Icons.rain
            
        case .snow:
            iconName = Icons.snow
            
        case .sleet:
            iconName = Icons.sleet
            
        case .wind:
            iconName = Icons.wind
            
        case .fog:
            iconName = Icons.fog
            
        case .cloudy:
            iconName = Icons.cloudy
        
        case .partlyCloudyDay:
            iconName = Icons.mostlyCloudy
            
        case .partlyCloudyNight:
            iconName = Icons.partlyCloudyNight
        }
        
        guard let name = iconName else { return UIImage() }
        return UIImage(named: name)!
    }

    @objc func getUserLocation() -> CLLocation {
        locationManager.startUpdatingLocation()
        
        guard let location = locationManager.location else { return CLLocation() }
        return location
    }
    
    public func getCity(_ location: CLLocation, _ completionHandler: @escaping(_ place: String?) -> ()) {
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if (error != nil) {
                return completionHandler(nil)
            }
        
            guard let place = placemarks?[0] else { return }
            guard let locality = place.locality else { return }
            completionHandler(locality)
        }
    }
    
    public func getForecast(_ location: CLLocation, _ completionHandler: @escaping(_ forecast: Forecast?, _ error: Error?) -> ()) {

        forecast.language = .english
        forecast.getForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
            
            switch result {
            case .success(let currentForecast, _):
                completionHandler(currentForecast, nil)
                
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    public func getLocalizedWeekDay(_ day: Int) -> String {
        let i = day - 1
        let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        
        return days[i]
    }
}
