//
//  DailyActivitySuitability.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import Foundation

protocol ActivitySuitabilityProvider {
    func getSuitability(dailyWeather: Daily) -> [ActivityScore]
}

struct DailyActivitySuitability: ActivitySuitabilityProvider {
    let indoorSightseeing: ActivitySuitability
    let outdoorSightseeing: ActivitySuitability
    let surfing: ActivitySuitability
    let skiing: ActivitySuitability
    
    init(indoorSightseeing: ActivitySuitability = IndoorSightseeingSuitability(),
         outdoorSightseeing: ActivitySuitability = OutdoorSightseeingSuitability(),
         surfing: ActivitySuitability = SurfingSuitability(),
         skiing: ActivitySuitability = SkiingSuitability()) {
        self.indoorSightseeing = indoorSightseeing
        self.outdoorSightseeing = outdoorSightseeing
        self.surfing = surfing
        self.skiing = skiing
    }
    
    func getSuitability(dailyWeather: Daily) -> [ActivityScore] {
        [
            indoorSightseeing.evaluateSuitability(weather: dailyWeather),
            outdoorSightseeing.evaluateSuitability(weather: dailyWeather),
            surfing.evaluateSuitability(weather: dailyWeather),
            skiing.evaluateSuitability(weather: dailyWeather)
        ]
    }
}
