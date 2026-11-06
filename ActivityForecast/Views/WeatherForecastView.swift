//
//  WeatherForecastView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import SwiftUI

struct WeatherForecastView: View {
    @State var viewModel: WeatherForecastViewModel
    
    init(city: City) {
        _viewModel = State(initialValue: WeatherForecastViewModel(city: city))
    }
    
    var body: some View {
        VStack {
            switch viewModel.screenState {
            case .loading:
                LoadingView()
            case .loaded:
                List {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(viewModel.city.displayName)
                            .font(.callout)
                    }
                    ActivityGridView(suggestedActivities: viewModel.suggestedActivities)
                    ForEach(viewModel.activityForecast, id: \.self) { forecast in
                        DailyForecastView(forecast: forecast)
                    }
                }
            case .error:
                ErrorView(meassage: viewModel.errorMessage)
            }
        }
        .navigationTitle("Activity forecast")
        .task {
            await viewModel.fetchForecastData()
        }
    }
}

#Preview {
    WeatherForecastView(city: City(id: 0, name: "", latitude: 0, longitude: 0, country: "", admin1: ""))
}
