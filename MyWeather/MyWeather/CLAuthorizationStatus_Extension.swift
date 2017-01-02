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
