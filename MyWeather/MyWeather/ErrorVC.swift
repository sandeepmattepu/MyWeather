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
    var empty : [String : Any] = [String : Any]()
    
    var failedReason : WeatherFailedReason!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        failedReasonLabel.text = failedReason.rawValue
    }
    
    // TODO remove this code
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: empty, completionHandler: nil)
    }
}
