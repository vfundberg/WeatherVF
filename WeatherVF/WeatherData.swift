//
//  WeatherData.swift
//  WeatherVF
//
//  Created by Victor Fundberg on 2018-03-27.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit

class WeatherData {
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var image : String = ""
    
    
    func changeWeatherImage(condition : Int) -> String {
        
        switch (condition) {
        case 200...232 :
            return "thunder"
        case 301...321, 520...531 :
            return "rainy"
        case 500...504 :
            return "suncloudrain"
        case 511, 600...622 :
            return "snow"
        case 700...781 :
            return "mist"
        case 800 :
            return "sunny"
        case 801 :
            return "sunnycloud"
        case 802 :
            return "cloudy"
        case 803, 804 :
            return "darkclouds"
        default :
            return ""
        }
    }
    
}

