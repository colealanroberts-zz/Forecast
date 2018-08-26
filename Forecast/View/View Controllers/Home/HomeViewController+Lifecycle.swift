//
//  HomeViewController+Lifecycle.swift
//  Forecast
//
//  Created by Cole Roberts on 8/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import Foundation
import UIKit
import WatchConnectivity

extension HomeViewController {
    
    @objc func refreshForecast() {
        
        let location = homeViewModel.getUserLocation()
        
        var cityForWatchOS: String?
        
        homeViewModel.getCity(location) { (city) in
            self.cityLabel.text = city
            cityForWatchOS = city
        }
        
        homeViewModel.getForecast(location) { (forecast, error) in
            
            if error != nil {
                self.showAlert(title: "Uh oh!", message: "There was a problem updating the weather data. Please try again.")
            }
            
            self.weeklyForecast = forecast?.daily.map {
                $0.data
            } ?? []
            
            guard let temp = forecast?.currently?.temperature else { return }
            
            var tempAsStr = String(describing: temp.rounded())
            tempAsStr = tempAsStr.replacingOccurrences(of: ".0", with: "")
            
            self.watchSession.sendMessage(["city": cityForWatchOS ?? "--", "temp": tempAsStr], replyHandler: nil, errorHandler: nil)
   
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
        
        if WCSession.isSupported() {
            watchSession.delegate = self
            watchSession.activate()
        }
        
        setNeedsStatusBarAppearanceUpdate()
        
        view.backgroundColor = Colors.black
        
        homeViewModel.locationManager.delegate = self
        homeViewModel.locationManager.requestAlwaysAuthorization()
        homeViewModel.locationManager.startUpdatingLocation()
        homeViewModel.notificationCenter.addObserver(self, selector: #selector(refreshForecast), name: UIApplication.didBecomeActiveNotification, object: nil)
    
        homeViewModel.spinner.center = self.view.center
        homeViewModel.spinner.color = Colors.white
        homeViewModel.spinner.startAnimating()
        
        self.view.addSubview(homeViewModel.spinner)
        
        refreshControl.addTarget(self, action: #selector(refreshForecast), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
}
