//
//  GeocodingServiceMock.swift
//  ActivityForecastTests
//
//  Created by Amol Bombe on 06/11/26.
//

import Foundation
@testable import ActivityForecast


class GeocodingServiceMock: GeocodingServicing {
    func search(query: String) async throws -> [City] {
        if query == "error" {
            throw NetworkError.invalidURL
        }
        return [City(id: 1234, name: "London", latitude: 34.4555, longitude: 56.4322, country: "United Kingdom", admin1: "England")]
    }
}
