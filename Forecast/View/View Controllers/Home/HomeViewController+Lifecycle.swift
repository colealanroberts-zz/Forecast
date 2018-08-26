//
//  HomeViewController+Lifecycle.swift
//  Forecast
//
//  Created by Cole Roberts on 8/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController {
    
    @objc func refreshForecast() {
        
        let location = homeViewModel.getUserLocation()
        
        homeViewModel.getCity(location) { (city) in
            self.cityLabel.text = city
        }
        
        homeViewModel.getForecast(location) { (forecast, error) in
            
            if error != nil {
                self.showAlert(title: "Uh oh!", message: "There was a problem updating the weather data. Please try again.")
            }
            
            self.weeklyForecast = forecast?.daily.map {
                $0.data
            } ?? []
   
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = Colors.darkGrey
        
        homeViewModel.locationManager.delegate = self
        homeViewModel.locationManager.requestAlwaysAuthorization()
        homeViewModel.locationManager.activityType = .fitness
        homeViewModel.locationManager.startUpdatingLocation()
        
        refreshControl.addTarget(self, action: #selector(refreshForecast), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
}
