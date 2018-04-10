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
    var humidity : Int = 0
    var windSpeed : Int = 0
    var city : String = ""
    var image : String = ""
    var clothesRecomendations : String = ""
    
    
    func changeWeatherImage(condition : Int) -> String {
        
        switch (condition) {
        case 200...232 :
            return "thunder"
        case 301...321, 520...531 :
            return "rainy"
        case 511, 600...622 :
            return "snow"
        case 700...781 :
            return "mist"
        case 800 :
            return "sunny"
        case 801 :
            return "sunnycloud"
        case 802 :
            return "darkclouds"
        case 803, 804 :
            return "darkclouds"
        default :
            return "dunno"
        }
    }
    func setClothesRecomendations(condition : Int, temperature : Int) -> String {
        switch (condition) {
        case 200...232 :
            return "Don't stand under a big tree, it might hurt"
        case 301...321, 520...531 :
            return "Bring an umbrella!"
        case 511, 600...622 :
            return "Dress warm and keep your feet warm. If they get cold, you're screwed."
        case 700...781 :
            return ""
        case 800 :
            if temperature > 15 {
                return "Don't forget to wear sunblock"
            } else {
                return "Don't let the sun fool you, bring an extra shirt"
            }
        case 801 :
            return "I suggest you bring a shirt, you never know with mother nature"
        case 802 :
            return "The weather is unpredictable today, I have no good advice for you."
        case 803, 804 :
            return "The weather is unpredictable today, I have no good advice for you."
        default :
            return "The weather is unpredictable today, I have no good advice for you."
        }
        
    
    }
    
    
}

