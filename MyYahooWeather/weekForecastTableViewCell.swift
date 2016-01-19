//
//  weekForecastTableViewCell.swift
//  MyYahooWeather
//
//  Created by Laibit on 2016/1/19.
//  Copyright © 2016年 Laibit. All rights reserved.
//

import UIKit

class weekForecastTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel:UILabel!
    @IBOutlet var highTemperatureLabel:UILabel!
    @IBOutlet var lowTemperatureLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dayLabel.textColor = UIColor.blackColor()
        dayLabel.font = UIFont(name: "HelveticaNeue", size: 22)
        dayLabel.sizeToFit()
        
        highTemperatureLabel.textColor = UIColor(red: 0.93, green: 0.60, blue: 0.28, alpha: 1)
        highTemperatureLabel.font = UIFont(name: "HelveticaNeue", size: 22)
        highTemperatureLabel.sizeToFit()
        
        lowTemperatureLabel.textColor = UIColor(red: 0.24, green: 0.59, blue: 0.86, alpha: 1)
        lowTemperatureLabel.font = UIFont(name: "HelveticaNeue", size: 22)
        lowTemperatureLabel.sizeToFit()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
