//
//  ActivityScore.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import Foundation

struct ActivityScore: Hashable {
    let score: Int
    let activity: UserActivity
    
    var rating: String {
        switch score {
        case 80...100:
            return "Excellent"
            
        case 60..<80:
            return "Good"
            
        case 40..<60:
            return "Moderate"
            
        case 20..<40:
            return "Poor"
            
        default:
            return "Very Poor"
        }
    }
}
