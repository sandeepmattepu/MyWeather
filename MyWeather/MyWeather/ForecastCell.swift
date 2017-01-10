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
    
    func configureCell(forecast : ForecastWeatherData?)
    {
        if let someForecast = forecast
        {
            dateLabel.text = someForecast.dateString
            weatherType.text = someForecast.weatherType
            if let weatherAssetName = someForecast.weatherTypeImageString
            {
                let imageToLoad = UIImage(named: weatherAssetName)
                weatherTypeImage.image = imageToLoad
            }
            minimumLabel.text = someForecast.minTemperature
            maximumLabel.text = someForecast.maxTemperature
        }
            // For empty cell, might be an ad
        else
        {
            dateLabel.text = ""
            weatherType.text = ""
            weatherTypeImage.image = nil
            minimumLabel.text = ""
            maximumLabel.text = ""
        }
    }
}
