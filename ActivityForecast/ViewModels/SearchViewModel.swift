//
//  SearchViewModel.swift
//  ActivityForecast
//
//  Created by Amol Bombe on 04/11/26.
//

import Foundation
import Observation

@Observable
class SearchViewModel {
    var cities: [City] = [City]()
    var searchText: String = ""
    var errorMessage = ""
    var screenState: ScreenState = .loaded
    
    let geocodingService: GeocodingServicing
    
    init(geocodingService: GeocodingServicing = GeocodingService()) {
        self.geocodingService = geocodingService
    }
    
    func fetchSearchResults() async {
        let string = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if string.isEmpty { return }
        screenState = .loading
        try? await Task.sleep(for: .seconds(0.5))
        do {
            let cityList: [City]? = try await geocodingService.search(query: string)
            screenState = .loaded
            guard let list = cityList else { return }
            
            await MainActor.run {
                cities = list
            }
            
        } catch let error as NetworkError {
            errorMessage = error.errorMessage
            screenState = .error
        } catch {
            screenState = .loaded
            print("\(error.localizedDescription)")
        }
    }
}
