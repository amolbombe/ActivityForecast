//
//  WeatherForecastService.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation

protocol WeatherForecastServicing {
    func forecast(latitude: Double, longitude: Double) async throws -> WeatherForecast
}

class WeatherForecastService: WeatherForecastServicing {
    let endPoint = EndPoint.forecast
    let networkClient: NetworkService
    
    init(networkClient: NetworkService = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func forecast(latitude: Double, longitude: Double) async throws -> WeatherForecast {
        guard var components = URLComponents(string: endPoint.baseUrl + endPoint.path) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "daily", value: [
                    "temperature_2m_max",
                    "temperature_2m_min",
                    "precipitation_probability_max",
                    "precipitation_sum",
                    "snowfall_sum",
                    "wind_speed_10m_max",
                    "wind_gusts_10m_max",
                    "sunshine_duration",
                    "rain_sum",
                    "wind_direction_10m_dominant",
                    "cloud_cover_mean",
                    "weather_code"
                ].joined(separator: ",")),
            URLQueryItem(name: "forecast_days", value: "7"),
            URLQueryItem(name: "timezone", value: "auto")
        ]
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method
        
        let response: WeatherForecast = try await networkClient.fetch(request: request)

        return response
    }
}
