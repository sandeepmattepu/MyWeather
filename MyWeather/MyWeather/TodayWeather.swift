//
//  CurrentTemperature.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/16/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation
import Alamofire

/**
    This class contains all the model layer details of today's weather. Use this class instance to make API request for
    today's weather.
 */
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
    
    /// Actual implementation making request to API and set the UI with the help of the closure sent as argument to the method
    private func downloadTodayWeatherAt(Latitude : Float, Longitude : Float, setUI : @escaping (String?)->Void)
    {
        let requestFromAPI = Alamofire.request(OpenWeatherAPI.getURLStringForCurrentWeatherAt(Latitude: Latitude, Longitude: Longitude))
        requestFromAPI.responseJSON(completionHandler: {
            response in
            if response.result.isSuccess
            {
                // Parsing JSON after downloading is success
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
                    setUI(self.weatherTypeImageString);
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
    
    /** This function is to parse and format all the weather data into proper decimal numbers, also to convert temperature from Kelvin to degrees centigrade
        - Parameter dicAtKeyMain: pass the dictionary which is parsed at "main" key
     */
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
                self.humidity = "\(humidValue)%"
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
    
    /// Handle failure if there is problem in downloading the weather data
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
    
    /**
        Use this function to download today's weather data based on the geometric co-ordinates and also to set the UI after downloading the data
     
        - Parameter setUI: pass a closure which has code to set UI
     
        - Parameter latitudeAndLongitude: Pass a float tupule which has latitude and longitude information
     */
    func updateObjectAndUI(setUI : @escaping (String?)->Void, latitudeAndLongitude :(Float,Float))
    {
        downloadTodayWeatherAt(Latitude: latitudeAndLongitude.0, Longitude: latitudeAndLongitude.1, setUI: setUI)
    }
}
