//
//  OpenWeatherAPI.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/15/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation
import Alamofire

struct OpenWeatherAPI
{
    private static let currentTempURL = "http://api.openweathermap.org/data/2.5/weather?"
    private static let forecastTempURL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
    private static let latitudeURL = "lat="
    private static let longitudeURL = "&lon="
    private static let endURLForCurrentTemp = "&appid="
    private static let endURLForForecast = "&cnt=10&mode=json&appid="
    private static let keyForAPI = "d0ece421fb2f6236408bd2fdf68df052"
    private static var urlToSendRequest : String!
    
    /**
        Build URL string using Latitude and Longitute values so that it can be used to make API calles.
        - Parameter Latitude: Enter latitude value
        - Parameter Longitude: Enter longitude value
        - Returns: This returns a string which contains http which can be used to make a request
    */
    static func getURLStringForCurrentWeatherAt(Latitude : Float, Longitude : Float) -> String
    {
        let finalURLString = (currentTempURL + latitudeURL + "\(Latitude)" + longitudeURL + "\(Longitude)" + endURLForCurrentTemp + keyForAPI)
        return finalURLString
    }
    
    static func getURLStringForForecast(Latitude : Float, Longitude : Float) -> String
    {
        let finalURLString = (forecastTempURL + latitudeURL + "\(Latitude)" + longitudeURL + "\(Longitude)" + endURLForForecast + keyForAPI)
        return finalURLString
    }
}
