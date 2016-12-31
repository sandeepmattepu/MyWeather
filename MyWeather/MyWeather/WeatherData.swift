//
//  WeatherData.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/16/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation

class WeatherData
{
    //date,temp(day),minTemp,maxTemp,humidity,weather,cityname
    var dateString : String = ""
    var averageTemperature : String = ""
    var minTemperature : String = ""
    var maxTemperature : String = ""
    var humidity : String = ""
    var weatherType : String = ""
    var cityName : String = ""
    
    init()
    {
    }
    
    /**
     Pass Array of weather data as parameters
    */
    final func setWeatherTypeFrom(arrayOfDic : Array<Dictionary<String,Any>>)
    {
        if arrayOfDic.count != 0
        {
            let weatherData = arrayOfDic.first!
            if let weatherInfo = weatherData["main"] as? String
            {   weatherType = weatherInfo   }
            else{   weatherType = "Unknown" }
        }
        else
        {
            weatherType = "Unknown"
        }
    }
}
