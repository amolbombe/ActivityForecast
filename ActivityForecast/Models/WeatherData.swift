//
//  WeatherData.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 05/11/26.
//

import Foundation

struct WeatherData {
    let daily: [Daily]
}

struct Daily {
    let date: String
    let temperature2mMax: Double
    let temperature2mmin: Double
    let precipitationProbabilityMax: Double
    let precipitationSum: Double
    let snowfallSum: Double
    let windSpeed10mMax: Double
    let windGusts10mMax: Double
    let sunshineDuration: Double
    let weatherCode: Int
    let rainSum: Double
    let windDirection10mDominant: Double
    let cloudCoverMean: Double
}
