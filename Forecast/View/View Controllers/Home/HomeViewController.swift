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

    var isLiteMode: Bool = false
    var homeViewModel: HomeViewModel = HomeViewModel()
    var selectedDay: DataPoint?
    var hourlyForecast = [DataPoint]()
    var weeklyForecast = [DataPoint]()
    let refreshControl = UIRefreshControl()
    let watchSession = WCSession.default
    
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
    
    @IBOutlet weak var uvLabel: UILabel! {
        didSet {
            uvLabel.textColor = Colors.white
        }
    }

    @IBOutlet weak var uvStaticLabel: UILabel! {
        didSet {
            uvStaticLabel.textColor = Colors.grey
        }
    }
    
    @IBOutlet weak var windSpeedLabel: UILabel! {
        didSet {
            windSpeedLabel.textColor = Colors.white
        }
    }
    
    @IBOutlet weak var windSpeedStaticLabel: UILabel! {
        didSet {
            windSpeedStaticLabel.textColor = Colors.grey
        }
    }
    
    @IBOutlet weak var humidityLabel: UILabel! {
        didSet {
            humidityLabel.textColor = Colors.white
        }
    }
    
    @IBOutlet weak var humidityStaticLabel: UILabel! {
        didSet {
            humidityStaticLabel.textColor = Colors.grey
        }
    }
    
    @IBOutlet weak var tableViewHeaderView: UIView! {
        didSet {
            tableViewHeaderView.backgroundColor = Colors.black
            tableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.alpha = 0.0
            tableView.backgroundColor = Colors.black
        }
    }

    @IBAction func contrastButtonPressed(_ sender: UIButton) {
        
        isLiteMode = !isLiteMode
        
        if isLiteMode {
            self.view.backgroundColor = Colors.white
            tableView.backgroundColor = Colors.white
            tableViewHeaderView.backgroundColor = Colors.white
            tableView.backgroundView?.backgroundColor = Colors.white
        } else {
            self.view.backgroundColor = Colors.darkGrey
            tableView.backgroundColor = Colors.darkGrey
            tableViewHeaderView.backgroundColor = Colors.darkGrey
            tableView.backgroundView?.backgroundColor = Colors.darkGrey
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

