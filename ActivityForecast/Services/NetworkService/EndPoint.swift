//
//  EndPoint.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation
enum EndPoint {
    case search
    case forecast
    
    var basrUrl: String {
        switch self {
        case .search:
            return "https://geocoding-api.open-meteo.com"
        case .forecast:
            return "https://api.open-meteo.com"
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/v1/search"
        case .forecast:
            return "/v1/forecast"
        }
    }
    
    var method: String? {
        return "GET"
    }
}
