//
//  HomeViewController+LocationDelegate.swift
//  Forecast
//
//  Created by Cole Roberts on 7/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import Foundation
import CoreLocation
import ForecastIO

extension HomeViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if status == .notDetermined {
            self.locationManager.requestAlwaysAuthorization()
        }

        if status == .authorizedAlways {
            self.locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }

        homeViewModel.getCity(location, { (city) in
            DispatchQueue.main.async {
                self.cityLabel.text = city
            }
        })
        
        homeViewModel.getForecast(location, { (forecast) in
            DispatchQueue.main.async {
                
                guard let temperature = forecast?.currently?.temperature else { return }
                guard let summary     = forecast?.currently?.summary else { return }
                
                let temp = temperature.rounded()
                var tempAsString = String(describing: temp)
                
                tempAsString = tempAsString.components(separatedBy: ".")[0]
                
                self.currentTemperatureLabel.text = tempAsString + "°"
                self.summaryLabel.text = summary
            }
        })
    }
}
