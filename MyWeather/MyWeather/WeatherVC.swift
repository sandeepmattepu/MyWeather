//
//  CurrentWeather.swift
//  StackyStacky
//
//  Created by Sandeep Yadav Mattepu on 12/15/16.
//  Copyright © 2016 Mattepu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import ReachabilitySwift
import Firebase

class WeatherVC : UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate
{
    @IBOutlet weak var averageTemp: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var cityNameLabel : UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    @IBOutlet weak var todayTempLoadingView : UIView!
    @IBOutlet weak var loadingTableView : UIView!
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var minTempLabel : UILabel!
    @IBOutlet weak var maxTempLabel : UILabel!
    @IBOutlet weak var adBannerView: GADBannerView!
    
    private var locationManager : CLLocationManager!
    private var todayTemperature = TodayWeather()
    private var forecastWeather = WrapperForForecastData()
    private var latitudeAndLongitude : (Double,Double) = (39,135)
    private let reachability = AppDelegate.rechability
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableVIew.dataSource = self
        tableVIew.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        AppDelegate.currentViewController = WeatherVC.self
        
        // To access location we need permission from user
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        locationManager = appDelegate.locationManager
        locationManager.delegate = self
        let authorizationStatus = CLLocationManager.authorizationStatus()
        print(CLAuthorizationStatus.statusInString(id: authorizationStatus.rawValue))
        // Parentel controlls turned on for restricted
        // User turned of for location services for denied
        if (authorizationStatus == .restricted) || (authorizationStatus == .denied)
        {
            performSegue(withIdentifier: "SorryView", sender: WeatherFailedReason.LOCATION_SERVICES_IS_OFF)
        }
        else if CLLocationManager.authorizationStatus() != .authorizedWhenInUse
        {
            locationManager.requestWhenInUseAuthorization()
        }
        else
        {
            // After retriving location check data connection and download data
            
            reachability.whenReachable = { reachability in
                DispatchQueue.main.async
                {
                    AppDelegate.hasConnectedToInternet = true
                    if AppDelegate.currentViewController != WeatherVC.self
                    {
                        self.dismiss(animated: true, completion: nil)
                    }
                    self.attemptDownloading()
                }
            }
            reachability.whenUnreachable = { reachability in
                DispatchQueue.main.async
                {
                    AppDelegate.hasConnectedToInternet = false
                    if AppDelegate.currentViewController == WeatherVC.self
                    {
                        self.performSegue(withIdentifier: "SorryView", sender: WeatherFailedReason.NO_INTERNET)
                    }
                }
            }
            do
            {
                try reachability.startNotifier()
            }
            catch
            {
                print("Unknown error")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return forecastWeather.arrayOfForeCast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastWeather") as? ForecastCell
        {
            cell.configureCell(forecast: forecastWeather.arrayOfForeCast[indexPath.row])
            return cell
        }
        return ForecastCell()
    }
    
    func updateUIForTodayTemperature(imageFileName : String?)
    {
        averageTemp.text = todayTemperature.averageTemperature
        weatherType.text = todayTemperature.weatherType
        cityNameLabel.text = todayTemperature.cityName
        humidityLabel.text = todayTemperature.humidity
        if imageFileName != nil
        {
            let image = UIImage(named: imageFileName!)
            imageView.image = image
        }
        todayTempLoadingView.isHidden = true
        minTempLabel.text = todayTemperature.minTemperature
        maxTempLabel.text = todayTemperature.maxTemperature
    }
    
    func setUIForForeCast()
    {
        tableVIew.reloadData()
        loadingTableView.isHidden = true
    }
    
    private func attemptDownloading()
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.desiredAccuracy = .leastNonzeroMagnitude
            locationManager.requestLocation()
        }
        else
        {
            // Please turn on location services
        }
        // Displaying ads
        attemptDisplayingADS()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse
        {
            if (AppDelegate.currentViewController != WeatherVC.self)
            {
                dismiss(animated: true, completion: nil)
                attemptDownloading()
            }
        }
        else if status == .denied
        {
            if (AppDelegate.currentViewController == WeatherVC.self)
            {
                performSegue(withIdentifier: "SorryView", sender: WeatherFailedReason.LOCATION_SERVICES_IS_OFF)
            }
        }
        else if status == .restricted
        {
            if (AppDelegate.currentViewController == WeatherVC.self)
            {
                performSegue(withIdentifier: "SorryView", sender: WeatherFailedReason.PARENTAL_CONTROL_ON)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let firstLocation = locations.first
        latitudeAndLongitude.0 = (firstLocation?.coordinate.latitude)!
        latitudeAndLongitude.1 = (firstLocation?.coordinate.longitude)!
        self.todayTemperature.updateObjectAndUI(setUI: self.updateUIForTodayTemperature,latitudeAndLongitude: (Float(latitudeAndLongitude.0),Float(latitudeAndLongitude.1)))
        let forecast = ForecastWeatherData()
        forecast.updateObjectAndUI(wrapperForForeCast: self.forecastWeather, setUI: self.setUIForForeCast,latitudeAndLongitude: (Float(self.latitudeAndLongitude.0),Float(self.latitudeAndLongitude.1)))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error.localizedDescription)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "SorryView"
        {
            if let failedReason = sender as? WeatherFailedReason
            {
                if let errorVC = segue.destination as? ErrorVC
                {
                    errorVC.failedReason = failedReason
                }
            }
        }
    }
    
    @IBAction func reloadWethterData(_ sender: UIButton)
    {
        attemptDownloading()
    }
    
    func attemptDisplayingADS()
    {
        let testID = "ca-app-pub-3940256099942544/2934735716"
        let releaseAdId = "ca-app-pub-6162837302788799/1387007067"
        adBannerView.adUnitID = testID
        adBannerView.rootViewController = self
        adBannerView.load(GADRequest())
    }
}

