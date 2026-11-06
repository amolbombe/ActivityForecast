//
//  ActivitySuitability.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import Foundation

protocol ActivitySuitability {
    func evaluateSuitability(weather: Daily) -> ActivityScore
}

/// Evaluate Suitability for Skiing Activity
struct SkiingSuitability: ActivitySuitability {
    func evaluateSuitability(weather: Daily) -> ActivityScore {
        var score = 0
        
        if weather.windSpeed10mMax < 30 {
            score += 20
        }
        
        if weather.precipitationSum < 2.5 {
            score += 15
        }
        
        if weather.temperature2mMax < 0 && weather.temperature2mMax > -10 {
            score += 30 // Great snow-preserving cold
        } else if weather.temperature2mMax >= 0 && weather.temperature2mMax < 5 {
            score += 20 // Borderline slushy
        } else if weather.temperature2mMax >= 5 {
            score = 10 // Rapid melting condition
        } else if weather.temperature2mMax <= -15 {
            score = 10 // Dangerously bitter cold
        }
        
        if weather.snowfallSum > 0.5 {
            score += 35 // Fresh powder bonus
        } else if weather.precipitationSum > 0 && weather.snowfallSum == 0 {
            score = 10 // Rain on a ski slope is a dealbreaker
        }
                
        let finalScore = max(0, min(100, score))
        
        return ActivityScore(score: finalScore, activity: .skiing)
    }
}

/// Evaluate Suitability for Surfing Activity
struct SurfingSuitability: ActivitySuitability {
    func evaluateSuitability(weather: Daily) -> ActivityScore {
        var score = 100
        
        // Without knowing the direction, any wind over 12 km/h could be onshore.
        // We scale penalties strictly based on wind speed velocity thresholds.
        if weather.windSpeed10mMax <= 10.0 {
            // Light winds mean clean or glassy conditions regardless of direction
            score -= 10
        } else if weather.windSpeed10mMax <= 18.0 {
            // Moderate wind creates texture/light chop
            score -= 35
        } else if weather.windSpeed10mMax <= 28.0 {
            // Strong wind likely blows out the surf zone
            score -= 60
        } else {
            // Heavy wind destroys surf conditions completely
            score -= 90
        }
        
        // MARK: - Global Safety & Environmental Penalties
        // High gusts create volatile, choppy, and dangerous peaks
        let gustSwellRatio = weather.windGusts10mMax - weather.windSpeed10mMax
        if gustSwellRatio > 15.0 {
            score -= 15
        }
        
        // Heavy downpours bring runoff/bacterial pollution risks
        if weather.rainSum > 2.0 {
            score -= 20
        }
        
        let finalscore = max(0, min(100, score))
        
        return ActivityScore(score: finalscore, activity: .surfing)
    }
}


/// Evaluate Outdoor Sightseeing Suitability for Activity
struct OutdoorSightseeingSuitability: ActivitySuitability {
    func evaluateSuitability(weather: Daily) -> ActivityScore {
        var score = 100
        
        // 1. Temperature Comfort (Ideal: 15°C to 25°C)
        if weather.temperature2mMax < 10 || weather.temperature2mMax > 32 {
            score -= 30 // Too cold or too hot for comfortable walking
        } else if weather.temperature2mMax < 15 || weather.temperature2mMax > 27 {
            score -= 10 // Slightly uncomfortable
        }
        
        // 2. Rain/Precipitation
        if weather.precipitationSum > 2.0 {
            score -= 50 // Heavy rain ruins walking tours
        } else if weather.precipitationSum > 0.2 {
            score -= 20 // Light drizzle annoyance
        }
        
        // 3. Wind disruption
        if weather.windSpeed10mMax > 30 {
            score -= 20 // Uncomfortably windy
        }
        
        let finalScore = max(0, min(100, score))
        return ActivityScore(score: finalScore, activity: .outdoorSightseeing)
    }
}

/// Evaluate Indoor Sightseeing Suitability for Activity
struct IndoorSightseeingSuitability: ActivitySuitability {
    func evaluateSuitability(weather: Daily) -> ActivityScore {
        var score = 60 // Standard base day
        
        // 1. Push users inside if it is raining
        if weather.precipitationSum > 2.0 {
            score += 40
        } else if weather.precipitationSum > 0.2 {
            score += 20
        }
        
        // 2. Push users inside if temperatures are brutal
        if weather.temperature2mMax < 5 || weather.temperature2mMax > 35 {
            score += 20
        }
        
        // 3. Pull users outside (lower indoor score) if the weather is glorious
        if weather.cloudCoverMean < 30 && weather.temperature2mMax >= 18 && weather.temperature2mMax <= 25 && weather.precipitationSum == 0 {
            score -= 20
        }
        
        let finalScore = max(0, min(100, score))
        return ActivityScore(score: finalScore, activity: .indoorSightseeing)
    }
}
