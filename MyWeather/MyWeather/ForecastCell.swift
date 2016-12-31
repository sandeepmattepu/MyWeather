//
//  ForecastCell.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/16/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell
{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherTypeImage: UIImageView!
    @IBOutlet weak var minimumLabel: UILabel!
    @IBOutlet weak var maximumLabel: UILabel!
    
    private var forecast = ForecastWeatherData()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configureCell(forecast : ForecastWeatherData)
    {
        dateLabel.text = forecast.dateString
        weatherType.text = forecast.weatherType
        let imageToLoad = UIImage(named: forecast.weatherType)
        weatherTypeImage.image = imageToLoad
        minimumLabel.text = forecast.minTemperature
        maximumLabel.text = forecast.maxTemperature
    }
}
