//
//  UserActivity.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 05/11/26.
//

import Foundation

enum UserActivity: String, Hashable {
    case skiing = "Skiing"
    case surfing = "Surfing"
    case outdoorSightseeing = "Outdoor"
    case indoorSightseeing = "Indoor"
    
    var icon: String {
        switch self {
        case .skiing:
            "figure.skiing.crosscountry"
        case .surfing:
            "figure.surfing"
        case .outdoorSightseeing:
            "figure.outdoor.cycle"
        case .indoorSightseeing:
            "building.columns"
        }
    }
}


