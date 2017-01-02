//
//  ErrorVC.swift
//  MyWeather
//
//  Created by Sandeep Yadav Mattepu on 12/31/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import UIKit

class ErrorVC: UIViewController
{

    @IBOutlet weak var failedReasonLabel : UILabel!
    
    var failedReason : WeatherFailedReason!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        failedReasonLabel.text = failedReason.rawValue
    }
}
