//
//  CurrentTemperature.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/16/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation
import Alamofire

class TodayWeather : WeatherData
{
    override init()
    {
        super.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let date = Date()
        self.dateString = dateFormatter.string(from: date)
    }
    private func downloadTodayWeatherAt(Latitude : Float, Longitude : Float, setUI : @escaping ()->Void)
    {
        let requestFromAPI = Alamofire.request(OpenWeatherAPI.getURLStringForCurrentWeatherAt(Latitude: Latitude, Longitude: Longitude))
        requestFromAPI.responseJSON(completionHandler: {
            response in
            if response.result.isSuccess
            {
                if let JSON = response.result.value as? Dictionary<String,Any>
                {
                    // Setting all temperatures
                    if let mainDic = JSON["main"] as? Dictionary<String,Any>
                    {
                        self.setAllTemperatures(dicAtKeyMain: mainDic)
                    }
                    else
                    {
                        let emptyDic = Dictionary<String,Any>()
                        self.setAllTemperatures(dicAtKeyMain: emptyDic)
                    }
                    
                    //Setting weather type
                    if let weatherArrayDic = JSON["weather"] as? Array<Dictionary<String, Any>>
                    {
                        self.setWeatherTypeFrom(arrayOfDic: weatherArrayDic)
                    }
                    else
                    {
                        let emptyArrayDic = Array<Dictionary<String,Any>>()
                        self.setWeatherTypeFrom(arrayOfDic: emptyArrayDic)
                    }
                    
                    //Setting city name
                    if let cityString = JSON["name"] as? String
                    {
                        self.cityName = cityString
                    }
                    else
                    {
                        self.cityName = "Unknown"
                    }
                    setUI()
                }
                else    // If response is success but JSON is invalid
                {
                    self.failureCode()
                }
            }
            else        // If response failed
            {
                self.failureCode()
            }
        })
    }
    
    private func setAllTemperatures(dicAtKeyMain : Dictionary<String, Any>)
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        if dicAtKeyMain.count != 0
        {
            if let tempValue = dicAtKeyMain["temp"] as? Double
            {
                let temp = tempValue - 273.15
                self.averageTemperature = "\(numberFormatter.string(from: NSNumber(value : temp))!)°C"
            }
            else{  self.averageTemperature = "Unknown"  }
            if let minTempValue = dicAtKeyMain["temp_min"] as? Double
            {
                let minTemp = minTempValue - 273.15
                self.minTemperature = "\(numberFormatter.string(from: NSNumber(value : minTemp))!)°C"
            }
            else{  self.minTemperature = "Unknown"  }
            if let maxTempValue = dicAtKeyMain["temp_max"] as? Double
            {
                let maxTemp = maxTempValue - 273.15
                self.maxTemperature = "\(numberFormatter.string(from: NSNumber(value : maxTemp))!)°C"
            }
            else{  self.maxTemperature = "Unknown"  }
            if let humidValue = dicAtKeyMain["humidity"] as? Double
            {
                self.humidity = "\(humidValue)"
            }
            else{  self.humidity = "Unknown"  }
        }
        else
        {
            self.averageTemperature = "Unknown"
            self.minTemperature = "Unknown"
            self.maxTemperature = "Unknown"
            self.humidity = "Unknown"
        }
    }
    
    private func failureCode()
    {
        // Set all values to nil or ""
        //Setting temperatures to empty
        let emptyTempDic = Dictionary<String,Any>()
        self.setAllTemperatures(dicAtKeyMain: emptyTempDic)
        let emptyArrayDic = Array<Dictionary<String,Any>>()
        self.setWeatherTypeFrom(arrayOfDic: emptyArrayDic)
        self.cityName = "Unknown"
    }
    
    func updateObjectAndUI(setUI : @escaping ()->Void, latitudeAndLongitude :(Float,Float))
    {
        downloadTodayWeatherAt(Latitude: latitudeAndLongitude.0, Longitude: latitudeAndLongitude.1, setUI: setUI)
    }
}
