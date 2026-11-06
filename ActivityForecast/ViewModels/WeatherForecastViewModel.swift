//
//  WeatherForecastViewModel.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation
import Observation

@Observable
class WeatherForecastViewModel {
    let forecastService: WeatherForecastServicing
    let city: City
    var weatherForecast: WeatherData?
    var errorMessage = ""
    var suitabilityProvider: ActivitySuitabilityProvider = DailyActivitySuitability()
    var activityForecast = [ActivityForecast]()
    var suggestedActivities = [SuggestedActivity]()
    var screenState: ScreenState = .loaded
    
    init(forecastService: WeatherForecastServicing = WeatherForecastService(), city: City) {
        self.forecastService = forecastService
        self.city = city
    }
    
    @MainActor
    func fetchForecastData() async {
        do {
            screenState = .loading
            let forecast: WeatherForecast = try await forecastService.forecast(latitude: city.latitude, longitude: city.longitude)
            screenState = .loaded
            weatherForecast = forecast.toDomain()
            guard let weatherForecast else { return }
            for weather in weatherForecast.daily {
                let activities = suitabilityProvider.getSuitability(dailyWeather: weather)
                activityForecast.append(ActivityForecast(date: weather.date, activityScore: activities))
            }
            updateSuggestions()
        } catch let error as NetworkError {
            errorMessage = error.errorMessage
            screenState = .error
        } catch {
            errorMessage = error.localizedDescription
            screenState = .error
        }
    }
    
    func updateSuggestions() {
        suggestedActivities = [
            getHighestScore(activity: .outdoorSightseeing),
            getHighestScore(activity: .indoorSightseeing),
            getHighestScore(activity: .surfing),
            getHighestScore(activity: .skiing)
        ]
    }
    
    func getHighestScore(activity: UserActivity) -> SuggestedActivity {
        var score = 0
        var date = ""
        for forecast in activityForecast {
            for activityScore in forecast.activityScore {
                if activityScore.activity == activity {
                    if score < activityScore.score {
                        score = activityScore.score
                        date = forecast.date
                    }
                }
            }
        }
        
        if score <= 40 {
            date = "Not Suitable"
        }
        
        return SuggestedActivity(date: date, activity: activity)
    }
}
