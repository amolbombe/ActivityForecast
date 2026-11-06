//
//  WeatherForecast.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation

struct WeatherForecast: Decodable {
    let daily: DailyWeather
    
    func toDomain() -> WeatherData {
        var dailyArray = [Daily]()
        for i in 0..<daily.time.count {
            let date = stringToDate(daily.time[i])?.dateForDisplay ?? ""
            let weather = Daily(date: date,
                                temperature2mMax: daily.temperature_2m_max[i],
                                temperature2mmin: daily.temperature_2m_min[i],
                                precipitationProbabilityMax: daily.precipitation_probability_max[i],
                                precipitationSum: daily.precipitation_sum[i],
                                snowfallSum: daily.snowfall_sum[i],
                                windSpeed10mMax: daily.wind_speed_10m_max[i],
                                windGusts10mMax: daily.wind_gusts_10m_max[i],
                                sunshineDuration: daily.sunshine_duration[i],
                                weatherCode: daily.weather_code[i],
                                rainSum: daily.rain_sum[i],
                                windDirection10mDominant: daily.wind_direction_10m_dominant[i],
                                cloudCoverMean: daily.cloud_cover_mean[i])
            dailyArray.append(weather)
        }
        return WeatherData(daily: dailyArray)
    }
    
    func stringToDate(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: string)
    }
}

extension Date {
    var dateForDisplay: String {
        [formatted(.dateTime.weekday()), formatted(.dateTime.day()), formatted(.dateTime.month())].joined(separator: " ")
    }
}

struct DailyWeather: Decodable {
    let time: [String]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let precipitation_probability_max: [Double]
    let precipitation_sum: [Double]
    let snowfall_sum: [Double]
    let wind_speed_10m_max: [Double]
    let wind_gusts_10m_max: [Double]
    let sunshine_duration: [Double]
    let weather_code: [Int]
    let rain_sum: [Double]
    let wind_direction_10m_dominant: [Double]
    let cloud_cover_mean: [Double]
}
