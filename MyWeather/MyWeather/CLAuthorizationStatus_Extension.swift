//
//  CLAuthorizationStatus_Extension.swift
//  MyWeather
//
//  Created by Sandeep Yadav Mattepu on 1/2/17.
//  Copyright © 2017 Mattepu. All rights reserved.
//

import Foundation
import CoreLocation

extension CLAuthorizationStatus
{
    /**
        This function will convert the CLAuthorizationStatus raw value which are in int to appropriate string values. Use this string values to understand the status of location authorization
        - Parameter id: pass CLAuthorizationStatus rawvalue
        - Returns: It returns a string which helps to understand the status of location authorization
    */
    static func statusInString(id : Int32) -> String
    {
        switch id
        {
        case 0:
            return "Not determined"
        case 1:
            return "Restricted"
        case 2:
            return "Denied"
        case 3:
            return "Authorized Always"
        case 4:
            return "Authorized when in use"
        default:
            return "Unknown"
        }
    }
}
