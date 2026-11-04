//
//  SearchView.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.cities, id: \.self) { city in
                    Text(city.displayName)
                }
            }
            .navigationTitle("Cities")
            .navigationDestination(for: City.self) { city in
//                WeatherView(weatherviewModel: WeatherViewModel(city: city))
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search city")
        .task(id: viewModel.searchText) {
            if viewModel.searchText.isEmpty { return }
            try? await Task.sleep(for: .seconds(0.5))
            await viewModel.fetchSearchResults(string: viewModel.searchText)
        }
    }
}

#Preview {
    SearchView()
}
