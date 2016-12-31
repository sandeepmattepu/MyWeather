//
//  WeatherData.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/16/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation

/**
    Parent class for all weather model classes. This class contains all basic properties to describe weather
 */
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
    var weatherTypeImageString : String? = nil
    
    init()
    {
    }
    
    /**
        Pass Array of weather data as parameters
        - Parameter arrayOfDic: Pass an array of dictionary to parse Weather type data
    */
    final func setWeatherTypeFrom(arrayOfDic : Array<Dictionary<String,Any>>)
    {
        if arrayOfDic.count != 0
        {
            let weatherData = arrayOfDic.first!
            
            if let weatherInfo = weatherData["main"] as? String
            {   weatherType = weatherInfo   }
            else{   weatherType = "Unknown" }
            
            if let weatherImage = weatherData["icon"] as? String
            {   weatherTypeImageString = weatherImage   }
        }
        else
        {
            weatherType = "Unknown"
        }
    }
}
