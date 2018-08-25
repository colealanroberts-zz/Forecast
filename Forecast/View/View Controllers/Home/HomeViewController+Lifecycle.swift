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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkGrey
        
        homeViewModel.locationManager.delegate = self
        homeViewModel.locationManager.requestAlwaysAuthorization()
        homeViewModel.locationManager.activityType = .fitness
        homeViewModel.locationManager.startUpdatingLocation()
    }
}
