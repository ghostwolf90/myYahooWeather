//
//  titleDataTableViewCell.swift
//  MyYahooWeather
//
//  Created by Laibit on 2016/1/19.
//  Copyright © 2016年 Laibit. All rights reserved.
//

import UIKit

class titleDataTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        weatherStatus.textColor = UIColor.blackColor()
        weatherStatus.font = UIFont(name: "HelveticaNeue", size: 22)
        weatherStatus.sizeToFit()
        
        temperatureLabel.textColor = UIColor.blackColor()
        temperatureLabel.font = UIFont(name: "HelveticaNeue", size: 22)
        temperatureLabel.sizeToFit()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
