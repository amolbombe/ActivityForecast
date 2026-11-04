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
}
