//
//  ViewController.swift
//  Forecast
//
//  Created by Cole Roberts on 7/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import UIKit
import CoreLocation
import WatchConnectivity

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let locationManager: CLLocationManager = CLLocationManager()
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var homeViewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityLabel: UILabel! {
        didSet {
            cityLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var currentTemperatureLabel: UILabel! {
        didSet {
            currentTemperatureLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var summaryLabel: UILabel! {
        didSet {
            summaryLabel.textColor = UIColor.gray
        }
    }
    
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    
    // MARK: - Private methods
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Lifeycle

    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = UIColor(red:0.01, green:0.02, blue:0.05, alpha:1.00)
        locationManager.requestAlwaysAuthorization()
        setupLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

