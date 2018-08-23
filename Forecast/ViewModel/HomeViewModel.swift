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
    
    let forecast = DarkSkyClient(apiKey: "b6e4edcb31a89fe6409e93e4aaaf6ac1")
    let geocoder: CLGeocoder = CLGeocoder()
    
    public func getCity(_ location: CLLocation, _ completionHandler: @escaping(_ place: String?) ->()) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if (error != nil) {
                return completionHandler(nil)
            }
        
            guard let place = placemarks?[0] else { return }
            guard let locality = place.locality else { return }
            completionHandler(locality)
        }
    }
    
    public func getForecast(_ location: CLLocation, _ completionHandler: @escaping(_ forecast: Forecast?) -> ()) {

        forecast.language = .english
        forecast.getForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
            
            switch result {
            case .success(let currentForecast, _):
                completionHandler(currentForecast)
                
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
    }
}
