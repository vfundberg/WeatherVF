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


class StartViewController: UIViewController, CLLocationManagerDelegate, NewCityDelegate {
    
    let URL = "http://api.openweathermap.org/data/2.5/weather"
    let APPID = "941747b308c30b1815669adf41489369"
    
    let locationManager = CLLocationManager()
    let weatherData =  WeatherData()
    var favorites : [WeatherData] = []
    var citys : [WeatherData] = []
    var cityFavorites : [String] = []
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var clothesRecomendations: UITextView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        view.bringSubview(toFront: temp)
        view.bringSubview(toFront: city)
        view.bringSubview(toFront: weatherImage)
        view.bringSubview(toFront: wind)
        view.bringSubview(toFront: humidity)
        view.bringSubview(toFront: clothesRecomendations)
        view.bringSubview(toFront: favoritesButton)
        view.bringSubview(toFront: searchButton)
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        let addCity = city.text
        citys.append(weatherData)
        cityFavorites.append(addCity!)
        print(cityFavorites)
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.addToFavoriteButton.alpha = 0.0
        }, completion: nil)
    }
    func showButtons(){
        for c in cityFavorites {
            if city.text == c {
                self.addToFavoriteButton.alpha = 0.0
                print("City is in favorite list, button not showing")
            } else {
                UIView.animate(withDuration: 0.5, delay: 1.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.addToFavoriteButton.alpha = 1.0
                    self.favoritesButton.alpha = 1.0
                    self.searchButton.alpha = 1.0
                }, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeather(url : String, parameters : [String : String]) {
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Got weather information")
                let weatherJSON : JSON = JSON(response.result.value)
                self.updateWeather(json: weatherJSON)
            } else {
                print("Error : \(response.result.error)")
                self.city.text = "Can't connect"
            }
        }
        
    }
    
    func updateWeather(json : JSON) {
        if let weatherResult = json["main"]["temp"].double {
            
            weatherData.temperature = Int(weatherResult - 273.15)
            weatherData.city = json["name"].stringValue
            weatherData.condition = json["weather"][0]["id"].intValue
            weatherData.windSpeed = json["wind"]["speed"].intValue
            weatherData.humidity = json["main"]["humidity"].intValue
            weatherData.image = weatherData.changeWeatherImage(condition: weatherData.condition)
            weatherData.clothesRecomendations = weatherData.setClothesRecomendations(condition: weatherData.condition, temperature: weatherData.temperature)
            
            print(weatherData.city)
            print(weatherData.temperature)
            print(weatherData.condition)
            print(weatherData.windSpeed)
            print(weatherData.humidity)
            print(weatherData.image)
            
            updateUI(newCity : weatherData)
            
        } else {
            city.text = "No Connection"
        }
    }
    
    func updateUI(newCity : WeatherData) {
        city.text = newCity.city
        temp.text = "\(newCity.temperature)º"
        weatherImage.image = UIImage(named: newCity.image)
        wind.text = "Wind Speed: \(newCity.windSpeed) m/s"
        humidity.text = "Humidity: \(newCity.humidity) %"
        clothesRecomendations.text = newCity.clothesRecomendations
        showButtons()
    }
    
    func updateUIFromFavorites(newCity: String) {
        let params : [String : String] = ["q" : newCity, "appid" : APPID]
        getWeather(url: URL, parameters: params)
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
    func enteredACity(theCity : String) {
        let params : [String : String] = ["q" : theCity, "appid" : APPID]
        getWeather(url: URL, parameters: params)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCity" {
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.delegate = self
        } else if segue.identifier == "showFavorites" {
            let destinationVC = segue.destination as! WeatherTableViewController
            destinationVC.delegate = self
            destinationVC.favoriteCities = cityFavorites
            destinationVC.cityList = favorites
        }

    }
}
