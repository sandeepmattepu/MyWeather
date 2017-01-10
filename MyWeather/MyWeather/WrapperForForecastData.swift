//
//  WrapperForForecastData.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/16/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation

/** This class is to pass Weather Data between Model and Controller. Arrays in swift are value types. So we wrap a class
    to pass data as reference type. This class also carries the information about noOfWeatherReports
 */
class WrapperForForecastData
{
    /// Array of ForecastWeatherData. Use this in collection views
    var arrayOfForeCast = Array<ForecastWeatherData>()
    /// no of weather reports that are availabe, initially it's value will be 0
    var noOfWeatherReports = 0
}
