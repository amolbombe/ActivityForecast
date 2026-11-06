//
//  NetworkError.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(Int)
    case noData
    case decodingError
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse(let error):
            return "Invalid response with error code \(error)"
        case .noData:
            return "Something went wrong, please try again"
        case .decodingError:
            return "Json decoding error"
        }
    }
}
