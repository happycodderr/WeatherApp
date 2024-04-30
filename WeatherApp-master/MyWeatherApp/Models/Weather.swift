//
//  Weather.swift
//  MyWeatherApp
//
//  Created by Geethanjali GV on 17/12/2021.
//

import Foundation

struct Weather:Codable, Identifiable {
    var dt: Int
    var temp:Double
    var feelsLike:Double
    var pressure:Int
    var humidity:Int
    var dewPoint:Double
    var clouds:Int
    var windSpeed:Double
    var windDeg:Int
    var weather:[WeatherDetail]
    
    enum CodingKeys:String, CodingKey{
        case dt, temp, pressure, humidity, clouds, weather
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
    }
    init() {
        dt = 0
        temp = 0.0
        feelsLike = 0.0
        pressure = 0
        humidity = 0
        dewPoint = 0.0
        clouds = 0
        windSpeed = 0.0
        windDeg = 0
        weather = []
    }
}
extension Weather {
    var id: UUID {
        return UUID()
    }
}
