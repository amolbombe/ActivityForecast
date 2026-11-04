//
//  NetworkService.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(request: URLRequest) async throws -> T
}

class NetworkClient: NetworkService {
    func fetch<T>(request: URLRequest) async throws -> T where T : Decodable {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw NetworkError.invalidResponse(response.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print(error)
            throw NetworkError.decodingError
        }
    }
}
