//
//  DailyForecastView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import SwiftUI

struct DailyForecastView: View {
    let forecast: ActivityForecast
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(forecast.date)
                .font(.title3)
                .fontWeight(.bold)

            ActivityScoreListView(forecast: forecast)
        }

    }
}
