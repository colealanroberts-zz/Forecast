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
import ForecastIO

class HomeViewController: BaseViewController {
    
    // MARK: - Properties

    var selectedDay: DataPoint?
    var homeViewModel: HomeViewModel = HomeViewModel()
    var hourlyForecast = [DataPoint]()
    var tableViewDataSource = [DataPoint]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityLabel: UILabel! {
        didSet {
            cityLabel.textColor = Colors.white
        }
    }
    
    @IBOutlet weak var currentTemperatureLabel: UILabel! {
        didSet {
            currentTemperatureLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var summaryLabel: UILabel! {
        didSet {
            summaryLabel.textColor = Colors.grey
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.image?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = UIColor.white
        }
    }
    
    @IBOutlet weak var tableViewHeaderView: UIView! {
        didSet {
            tableViewHeaderView.backgroundColor = Colors.darkGrey
            tableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = Colors.darkGrey
        }
    }
    
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

