//
//  WeatherFailedReason.swift
//  MyWeather
//
//  Created by Sandeep Yadav Mattepu on 1/2/17.
//  Copyright © 2017 Mattepu. All rights reserved.
//

import Foundation

enum WeatherFailedReason : String
{
    case NO_INTERNET = "No internet connection"
    case LOCATION_SERVICES_IS_OFF = "Location services is turned off"
    case PARENTAL_CONTROL_ON = "Parental control is on"
}
