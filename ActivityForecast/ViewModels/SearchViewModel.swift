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
    
    let geocodingService: GeocodingService 
    
    init(geocodingService: GeocodingService = GeocodingService()) {
        self.geocodingService = geocodingService
    }
    
    func fetchSearchResults(string: String) async {
        do {
            let cityList: [City]? = try await geocodingService.search(query: string)
            
            guard let list = cityList else { return }
            
            cities = list
            
        } catch let error {
            // Show Error View
        }
    }
}
