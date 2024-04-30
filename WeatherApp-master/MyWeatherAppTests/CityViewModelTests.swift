//
//  CityViewModelTests.swift
//  MyWeatherAppTests
//
//  Created by Geethanjali GV on 20/12/2021.
//

import XCTest
@testable import MyWeatherApp

class CityViewModelTests: XCTestCase {
    var cityVM = CityViewViewModel()
    var networkManager = MockNetworkManager()
    var weatherData:WeatherResponse?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetWeatherInternal_Success() {
     
        networkManager.parseJSON { weatherData in
            if let weatherData = weatherData  {
                XCTAssertEqual(weatherData.current.humidity, 78)
                XCTAssertEqual(weatherData.daily.description, "overcast clouds")
                XCTAssertEqual(weatherData.hourly[0].temp, 279.63)
            }
        }
    }
}
