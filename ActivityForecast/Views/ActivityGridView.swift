//
//  ActivityGridView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 06/11/26.
//

import SwiftUI

struct ActivityGridView: View {
    var suggestedActivities: [SuggestedActivity]
    let columns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(suggestedActivities, id: \.self) { activity in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.black)
                    HStack {
                        Image(systemName: activity.activity.icon)
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 8)
                        VStack(alignment: .center, spacing: 2) {
                            Text(activity.activity.rawValue)
                            Text(activity.date)
                        }
                        .padding(.vertical, 4)
                        .font(.callout)
                        .foregroundStyle(Color.white)
                    }
                }
            }
        }
    }
}

#Preview {
    ActivityGridView(suggestedActivities: [SuggestedActivity(date: "8 Nov", activity: .surfing)])
}
