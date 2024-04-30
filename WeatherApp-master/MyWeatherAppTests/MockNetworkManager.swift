//
//  MockNetworkManager.swift
//  MyWeatherAppTests
//
//  Created by Geethanjali GV on 20/12/2021.
//

import Foundation
@testable import MyWeatherApp


class MockNetworkManager {

//    func fetch<T>(type:T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
//        let bundle = Bundle(for:MockNetworkManager.self)
//
//        guard let urlString = bundle.url(forResource: "WeatherDetails", withExtension: "json"),
//              let data = try? Data(contentsOf: urlString)
//
//        else {
//            completion(.failure(NetworkError.invalidResponse))
//            return
//        }
//        completion(.success(data as! T))
//        print(data)
//    }
    func parseJSON(_ completion: @escaping (WeatherResponse?) -> Void) {
        if let url = Bundle.main.url(forResource: "WeatherDetails", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(WeatherResponse.self, from: data)
                completion(jsonData)
            } catch {
                print("error while decoding the JSON data")
                completion(nil)
            }
        }
    }
    }
    
     
        

   
    

