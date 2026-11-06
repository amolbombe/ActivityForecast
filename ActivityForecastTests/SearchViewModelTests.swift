//
//  SearchViewModelTests.swift
//  ActivityForecastTests
//
//  Created by Amol Bombe on 06/11/26.
//

import Testing
@testable import ActivityForecast

struct SearchViewModelTests {
    let sut: SearchViewModel = SearchViewModel(geocodingService: GeocodingServiceMock())

    @Test func fetchSearchResultsTest() async throws {
        await MainActor.run {
            sut.searchText = "london"
        }
        await sut.fetchSearchResults()
        #expect(!sut.cities.isEmpty)
    }
    
    @Test func fetchResultsWithEmptySearchTextTest() async throws {
        await sut.fetchSearchResults()
        #expect(sut.cities.isEmpty)
    }
    
    @Test func fetchResultsWithErrorTest() async throws {
        await MainActor.run {
            sut.searchText = "error"
        }
        await sut.fetchSearchResults()
        #expect(sut.screenState == .error)
        #expect(sut.cities.isEmpty)
    }
}
