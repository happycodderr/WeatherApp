//
//  CityViewViewModel.swift
//  MyWeatherApp
//
//  Created by Geethanjali GV on 18/12/2021.
//

import Foundation
import SwiftUI
import CoreLocation

class CityViewViewModel:ObservableObject {
    
    var networkManager:Networkable = NetworkManager()
    @Published var weather = WeatherResponse.empty()
    
    @Published var city:String = "London" {
        didSet {
            //call get location here
            getLocation()
        }
    }
    private lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        // getLocation() -> Call
        getLocation()
    }
    
    var date:String {
        return dateFormatter.string(from:Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon:String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "dayClearSky"
        }
    
    var temperature:String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var feelsLikeTemp:String {
        return getFeelsLikeFor(feelsLike: weather.current.feelsLike)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0{
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.windSpeed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String{
        return String(format:"%0.0f%%",weather.current.dewPoint)
    }
    
    func getTimeFor(timestamp: Int)->String {
        return timeFormatter.string(from:Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
     
    func getTempFor(temp:Double)->String {
        return String(format: "%0.0f", temp)
    }
    
    func getFeelsLikeFor(feelsLike:Double)->String {
        return String(format: "%0.0f", feelsLike)
    }
    
    func getDayFor(timestamp: Int)->String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
     func getLocation()
    {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
     func getWeather(coord: CLLocationCoordinate2D?) {
        if let _coord = coord {
            let urlString = API.getURLFor(lat: _coord.latitude, lon: _coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = API.getURLFor(lat: 51.5072, lon: 0.1276)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
     func getWeatherInternal(city: String, for urlString:String) {
        networkManager.fetch(for: URL(string: urlString)!, type:WeatherResponse.self) { (result) in
            switch result {
            case.success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case.failure(let err):
                print(err)
            }
        }
    }
    
    func getLottieAnimationFor(icon:String)->String {
        switch icon {
        case "01d":
            return "dayClearSky"
        case "01n":
            return "nightClearSky"
        case "02d":
            return "dayFewClouds"
        case "02n":
            return "nightFewClouds"
        case "03d":
            return "dayScatteredClouds"
        case "03n":
            return "nightScatterdClouds"
        case "04d":
            return "dayBrokenClouds"
        case "04n":
            return "nightBrokenClouds"
        case "09d":
            return "dayShowerRains"
        case "09n":
            return "nightShowerRains"
        case "10d":
            return "dayRain"
        case "10n":
            return "nightRain"
        case "11d":
            return "dayThunderstorm"
        case "11n":
            return "nightThunderstorm"
        case "13d":
            return "daySnow"
        case "13n":
            return "nightSnow"
        case "50d":
            return "dayMist"
        case "50n":
            return "nightMist"
        default:
            return "dayClearSky"
        }
    }
    
    func getWeatherIconFor(icon:String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill") // clear sky day
        case "01n":
            return Image(systemName: "moon.fill") // clear sky night
        case "02d":
            return Image(systemName: "cloud.sun.fill") // few clouds day
        case "02n":
            return Image(systemName: "cloud.moon.fill") // few clouds night
        case "03d":
            return Image(systemName: "cloud.fill") // scattered clouds
        case "03n":
            return Image(systemName: "cloud.fill") // scattered clouds
        case "04d":
            return Image(systemName: "cloud.fill") // broken clouds
        case "04n":
            return Image(systemName: "cloud.fill") // broken clouds
        case "09d":
            return Image(systemName: "cloud.drizzle.fill") // rain showers
        case "09n":
            return Image(systemName: "cloud.drizzle.fill") // rain showers
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill") // rainy day
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill") // rainy night
        case "11d":
            return Image(systemName: "cloud.bolt.fill") // thunderstorm day
        case "11n":
            return Image(systemName: "cloud.bolt.fill") // thunderstorm night
        case "13d":
            return Image(systemName: "cloud.snow.fill") // snow
        case "13n":
            return Image(systemName: "cloud.snow.fill") // snow
        case "50d":
            return Image(systemName: "cloud.fog.fill") // mist
        case "50n":
            return Image(systemName: "cloud.fog.fill") // mist
        default:
            return Image(systemName: "sun.max.fill") // sunny
        }
    }
}
