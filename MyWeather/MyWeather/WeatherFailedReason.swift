//
//  WeatherFailedReason.swift
//  MyWeather
//
//  Created by Sandeep Yadav Mattepu on 1/2/17.
//  Copyright © 2017 Mattepu. All rights reserved.
//

import Foundation

/**
    Use this enum to describe the failed reason to show the weather. Pass this enum to other view controller which will show appropriate UI. Use the raw values which are strings to extract the reason for the failure
 */
enum WeatherFailedReason : String
{
    /// No internet connection
    case NO_INTERNET = "No internet connection"
    /// Location services is turned off
    case LOCATION_SERVICES_IS_OFF = "Location services is turned off"
    /// Parental control is on for Location
    case PARENTAL_CONTROL_ON = "Parental control is on for Location"
}
