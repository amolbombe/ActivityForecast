//
//  SearchView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import SwiftUI

enum ScreenState {
    case loading
    case loaded
    case error
}

struct SearchView: View {
    @State var viewModel = SearchViewModel()
        
    var body: some View {
        NavigationStack {
            switch viewModel.screenState {
            case .loading:
                LoadingView()
            case .loaded:
                cityListView()
            case .error:
                ErrorView(meassage: viewModel.errorMessage)
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search city for activity forecast")
        .task(id: viewModel.searchText) {
            await viewModel.fetchSearchResults()
        }
    }
    
    fileprivate func cityListView() -> some View {
        return List {
            ForEach(viewModel.cities, id: \.self) { city in
                NavigationLink(value: city) {
                    Text(city.displayName)
                }
            }
        }
        .navigationTitle("Search City")
        .navigationDestination(for: City.self) { city in
            WeatherForecastView(city: city)
        }
    }
}

#Preview {
    SearchView()
}
