//
//  NetworkManager.swift
//  MyWeatherApp
//
//  Created by Geethanjali GV on 17/12/2021.
//

import Foundation
import Combine

protocol Networkable {
    func fetch<T:Codable>(for url: URL, type:T.Type, completion:@escaping (Result<T, NetworkError>)->Void)
}

import Foundation

final class NetworkManager:Networkable {
    
    func fetch<T:Codable>(for url: URL, type:T.Type, completion: @escaping (Result<T, NetworkError>)->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let _data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let json = try JSONDecoder().decode(T.self, from: _data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
}



enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}
