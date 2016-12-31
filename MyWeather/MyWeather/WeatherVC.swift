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

class WeatherVC : UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate
{
    @IBOutlet weak var averageTemp: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var cityNameLabel : UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    @IBOutlet weak var todayTempLoadingView : UIView!
    @IBOutlet weak var loadingTableView : UIView!
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var sorryView: UIView!
    
    private var locationManager : CLLocationManager!
    private var todayTemperature = TodayWeather()
    private var forecastWeather = WrapperForForecastData()
    private var latitudeAndLongitude : (Double,Double) = (39,135)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableVIew.dataSource = self
        tableVIew.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        locationManager = appDelegate.locationManager
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied
        {
            // Sad face
            sorryCodeForNoWeather()
        }
        else if CLLocationManager.authorizationStatus() != .authorizedWhenInUse
        {
            locationManager.requestWhenInUseAuthorization()
        }
        else
        {
            attemptDownloading()
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
    
    func updateUIForTodayTemperature()
    {
        averageTemp.text = todayTemperature.averageTemperature
        dateLabel.text = todayTemperature.dateString
        weatherType.text = todayTemperature.weatherType
        cityNameLabel.text = todayTemperature.cityName
        humidityLabel.text = todayTemperature.humidity
        let weatherTypeAssetName = todayTemperature.weatherType.capitalized
        let imageToLoad = UIImage(named: weatherTypeAssetName)
        imageView.image = imageToLoad
        todayTempLoadingView.isHidden = true
    }
    
    func setUIForForeCast()
    {
        tableVIew.reloadData()
        loadingTableView.isHidden = true
    }
    
    @IBAction func backPressed(sender : UIButton)
    {
        dismiss(animated: true, completion: nil)
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
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse
        {
            sorryView.isHidden = true
            attemptDownloading()
        }
        else if status == .denied || status == .restricted
        {
            // sad face
            sorryCodeForNoWeather()
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
    
    func sorryCodeForNoWeather()
    {
        sorryView.isHidden = false
    }
}

