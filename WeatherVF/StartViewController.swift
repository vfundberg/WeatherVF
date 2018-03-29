//
//  StartViewController.swift
//  WeatherVF
//
//  Created by Victor Fundberg on 2018-03-26.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class StartViewController: UIViewController, CLLocationManagerDelegate {
    
    let URL = "http://api.openweathermap.org/data/2.5/weather"
    let APPID = "941747b308c30b1815669adf41489369"
    
    let locationManager = CLLocationManager()
    let weatherData =  WeatherData()
    
    
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        view.bringSubview(toFront: temp)
        view.bringSubview(toFront: city)
        view.bringSubview(toFront: weatherImage)
        view.bringSubview(toFront: searchButton)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeather(url : String, parameters : [String : String]) {
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Fick väderinformation")
                let weatherJSON : JSON = JSON(response.result.value)
                self.updateWeather(json: weatherJSON)
            } else {
                print("Error : \(response.result.error)")
                self.city.text = "Kan ej ansluta"
            }
        }
        
    }
    
    func updateWeather(json : JSON) {
        if let weatherResult = json["main"]["temp"].double {
            
            weatherData.temperature = Int(weatherResult - 273.15)
            weatherData.city = json["name"].stringValue
            weatherData.condition = json["weather"][0]["id"].intValue
            weatherData.image = weatherData.changeWeatherImage(condition: weatherData.condition)
            
            print(weatherData.city)
            print(weatherData.temperature)
            print(weatherData.condition)
            print(weatherData.image)
            
            updateUI()
            
        } else {
            city.text = "Ingen anslutning"
        }
    }
    
    func updateUI() {
        city.text = weatherData.city
        temp.text = "\(weatherData.temperature)º"
        weatherImage.image = UIImage(named: weatherData.image)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APPID]
            
            getWeather(url: URL, parameters: params)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
