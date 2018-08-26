//
//  DailyWeatherTableViewCell.swift
//  Forecast
//
//  Created by Cole Roberts on 8/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = Colors.grey
        }
    }
    
    @IBOutlet weak var tempHighLabel: UILabel! {
        didSet {
            tempHighLabel.textColor = Colors.brandRed
        }
    }
    
    @IBOutlet weak var tempLowLabel: UILabel! {
        didSet {
            tempLowLabel.textColor = Colors.brandBlue
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.tintColor = Colors.white
            iconImageView.contentMode = .center
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
