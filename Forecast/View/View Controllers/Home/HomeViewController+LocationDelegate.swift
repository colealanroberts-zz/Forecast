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
    
    fileprivate func revealUI() {
        DispatchQueue.main.async {
            self.homeViewModel.spinner.stopAnimating()
            
            UIView.animate(withDuration: 1.2, animations: {
                self.tableView.alpha = 1.0
            })
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch(status) {
        
        case .notDetermined:
            homeViewModel.locationManager.requestWhenInUseAuthorization()
            
        case .denied:
            // TODO
            print("Show the user a message...")
            
        case .restricted:
            print("Show the user a message...")
            
        case .authorizedWhenInUse:
            homeViewModel.locationManager.startUpdatingLocation()
            
        case .authorizedAlways:
            homeViewModel.locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }

        homeViewModel.getCity(location, { (city) in
            DispatchQueue.main.async {
                self.cityLabel.text = city
            }
        })
        
        homeViewModel.getForecast(location, { (forecast, error) in
            
            if (error != nil) {
                print("Uh oh...")
            }
            
            self.hourlyForecast = forecast?.hourly.map {
                $0.data
            } ?? []
            
            self.weeklyForecast = forecast?.daily.map {
                $0.data
            } ?? []

            guard let icon = forecast?.currently?.icon else { return }
            let iconImage = self.homeViewModel.getIcon(icon)

            DispatchQueue.main.async {
                
                guard let temperature = forecast?.currently?.temperature else { return }
                guard let summary     = forecast?.currently?.summary else { return }
                guard let humidity    = forecast?.currently?.humidity else { return }
                guard let windSpeed   = forecast?.currently?.windSpeed else { return }
                guard let uvIndex     = forecast?.currently?.uvIndex else { return }
                
                // Temp
                
                let temp = temperature.rounded()
                var tempAsString = String(describing: temp)
                tempAsString = tempAsString.components(separatedBy: ".")[0]
                
                // Humidity
                
                var humidityAsPercent = humidity * 100
                humidityAsPercent = humidityAsPercent.rounded()
                
                // Windspeed
                
                var windSpeedAsString = String(describing: windSpeed.rounded())
                windSpeedAsString = windSpeedAsString.components(separatedBy: ".")[0]
                
                // Update UI
                
                self.currentTemperatureLabel.text = tempAsString + "°"
                self.summaryLabel.text = summary
                self.humidityLabel.text = String(describing: humidityAsPercent) + "%"
                self.windSpeedLabel.text = windSpeedAsString + " mph"
                
                self.uvLabel.text = String(describing: uvIndex)
                self.iconImageView.image = iconImage
                
                self.tableView.reloadData()
                self.revealUI()
            }
        })
    
        manager.stopUpdatingLocation()
    }
}
