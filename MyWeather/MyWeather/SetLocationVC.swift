//
//  SetLocationVC.swift
//  MyWeather
//
//  Created by Sandeep Yadav Mattepu on 1/4/17.
//  Copyright © 2017 Mattepu. All rights reserved.
//

import UIKit

class SetLocationVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        AppDelegate.currentViewController = SetLocationVC.self
    }
    
    @IBAction func takeMeToSettingsPressed(_ sender: UIButton)
    {
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
        {
            let emptyDic = Dictionary<String,Any>()
            UIApplication.shared.open(settingsURL, options: emptyDic, completionHandler: nil)
        }
    }
}
