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
    
    @IBOutlet weak var grantPermissionButton: UIButton!
    var failedReason : WeatherFailedReason!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        failedReasonLabel.text = failedReason.rawValue
        
        if failedReason == WeatherFailedReason.PARENTAL_CONTROL_ON
        {
            grantPermissionButton.isHidden = true
        }
    }
    
    // TODO remove this code
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        AppDelegate.currentViewController = ErrorVC.self
    }
}
