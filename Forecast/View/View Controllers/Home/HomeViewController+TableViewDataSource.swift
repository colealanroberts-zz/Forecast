//
//  HomeViewController+TableViewDataSource.swift
//  Forecast
//
//  Created by Cole Roberts on 8/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell") as! DailyWeatherTableViewCell
        
        let day = tableViewDataSource[indexPath.row]
        
        guard let tempLow  = day.temperatureLow else { return cell }
        guard let tempHigh = day.temperatureHigh else { return cell }
        
        var tempLowStr  = String(describing: tempLow.rounded())
        var tempHighStr = String(describing: tempHigh.rounded())
        
        tempLowStr  = tempLowStr.replacingOccurrences(of: ".0", with: "")
        tempHighStr = tempHighStr.replacingOccurrences(of: ".0", with: "")
        
        cell.tempLowLabel.text  = tempLowStr
        cell.tempHighLabel.text = tempHighStr
        
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: day.time)
        
        cell.dayLabel.text = homeViewModel.getLocalizedWeekDay(weekDay)
        
        cell.backgroundColor = Colors.darkGrey
        
        if let icon = day.icon {
            let image = homeViewModel.getIcon(icon)
            
            cell.iconImageView.image = image
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

}
