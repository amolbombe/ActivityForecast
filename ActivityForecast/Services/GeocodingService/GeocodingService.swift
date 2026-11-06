//
//  GeocodingService.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation

protocol GeocodingServicing {
    func search(query: String) async throws -> [City]
}

struct GeocodingService: GeocodingServicing {
    let endPoint = EndPoint.search
    let networkClient: NetworkService
    
    init(networkClient: NetworkService = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func search(query: String) async throws -> [City] {
        guard var components = URLComponents(string: endPoint.baseUrl + endPoint.path) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "name", value: query),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "format", value: "json")
        ]
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method
        
        let response: GeocodingResponse = try await networkClient.fetch(request: request)

        return response.results ?? []
    }
}
