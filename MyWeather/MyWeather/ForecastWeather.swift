//
//  ForecastWeather.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/16/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation
import Alamofire

class ForecastWeatherData : WeatherData
{
    private var _numberOfWeatherReports : Int = 0
    var numberOfWeatherReports : Int
        {   return  _numberOfWeatherReports     }
    
    //day name, weather type, min temp, max temp
    private func downloadForeCastWeatherAt(Latitude : Float, Longitude : Float, wrapperForForecast : WrapperForForecastData, setUI : @escaping ()->Void)
    {
        let requestFromAPI = Alamofire.request(OpenWeatherAPI.getURLStringForForecast(Latitude: Latitude, Longitude: Longitude))
        requestFromAPI.responseJSON(completionHandler: {
            response in
            if response.result.isSuccess
            {
                if let JSON = response.result.value as? Dictionary<String,Any>
                {
                    if let list = JSON["list"] as? Array<Dictionary<String,Any>>
                    {
                        if let count = JSON["cnt"] as? Int
                        {
                            self._numberOfWeatherReports = count
                            for dictionaryAtIndex in list
                            {
                                let forecast = ForecastWeatherData()
                                if let dateStamp = dictionaryAtIndex["dt"] as? Int
                                {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.timeStyle = .none
                                    dateFormatter.dateFormat = "EEEE"
                                    let date = Date(timeIntervalSince1970: TimeInterval(dateStamp))
                                    forecast.dateString = dateFormatter.string(from: date)
                                }
                                if let temp = dictionaryAtIndex["temp"] as? Dictionary<String,Any>
                                {
                                    let numberFormatter = NumberFormatter()
                                    numberFormatter.numberStyle = .decimal
                                    numberFormatter.maximumFractionDigits = 2
                                    
                                    var minimumTemperature = temp["min"] as! Double
                                    minimumTemperature = minimumTemperature - 273.15
                                    forecast.minTemperature = "\(numberFormatter.string(from: NSNumber(value: minimumTemperature))!)°C"
                                    
                                    var maximumTemperature = temp["max"] as! Double
                                    maximumTemperature = maximumTemperature - 273.15
                                    forecast.maxTemperature = "\(numberFormatter.string(from: NSNumber(value: maximumTemperature))!)°C"
                                }
                                if let weatherArray = dictionaryAtIndex["weather"] as? Array<Dictionary<String,Any>>
                                {
                                    let firstweather = weatherArray.first!
                                    if let weathertypeValue = firstweather["main"] as? String
                                    {
                                        forecast.weatherType = weathertypeValue
                                    }
                                }
                                wrapperForForecast.arrayOfForeCast.append(forecast)
                            }
                            setUI()
                        }
                    }
                    else    // If array is failed
                    {   self.failureCode()      }
                }
                else        // If JSON failed
                {   self.failureCode()  }
            }
            else        // If response failed
            {   self.failureCode()  }
        })
    }
    
    private func failureCode()
    {
        // Set all values to nil or ""
        self.dateString = "Unknown"
        self.weatherType = "Unknown"
        self.minTemperature = "Unknown"
        self.maxTemperature = "Unknown"
    }
    
    func updateObjectAndUI(wrapperForForeCast : WrapperForForecastData, setUI : @escaping ()->Void, latitudeAndLongitude :(Float,Float))
    {
        downloadForeCastWeatherAt(Latitude: latitudeAndLongitude.0, Longitude: latitudeAndLongitude.1, wrapperForForecast: wrapperForForeCast, setUI: setUI)
    }
}
