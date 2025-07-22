//
//  WeatherTVC.swift
//  weather-api
//
//  Created by iroid on 22/07/25.
//

import UIKit

class WeatherTVC: UITableViewCell{
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var descriptionC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
