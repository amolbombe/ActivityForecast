//
//  ActivityScoreListView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import SwiftUI

struct ActivityScoreListView: View {
    let forecast: ActivityForecast

    var body: some View {
        HStack {
            ForEach(forecast.activityScore, id: \.self) { activity in
                VStack(alignment: .center) {
                    Text(activity.activity.rawValue)
                        .font(.callout)
                    Text(activity.score.description)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(activity.rating)
                        .font(.caption)
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                }
                .padding(4)
                .frame(width: 80)
                .foregroundStyle(activity.score > 60 ? Color.green : activity.score > 40 ? Color.yellow : Color.red)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(activity.score > 60 ? Color.green.opacity(0.2) : activity.score > 40 ? Color.yellow.opacity(0.2) : Color.red.opacity(0.2))
                }
            }
        }
    }
}
