//
//  DailyWeather.swift
//  MyWeatherApp
//
//  Created by Geethanjali GV on 17/12/2021.
//

import Foundation
struct DailyWeather: Codable, Identifiable {
    var dt:Int
    var temp:Temperature
    var weather: [WeatherDetail]
    
    init() {
        dt = 0
        temp = Temperature(min: 0.0, max: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
}

extension DailyWeather {
    var id:UUID {
        return UUID()
    }
}
