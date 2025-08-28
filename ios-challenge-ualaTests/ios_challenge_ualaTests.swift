//
//  ios_challenge_ualaTests.swift
//  ios-challenge-ualaTests
//
//  Created by Franco Zelener on 27/08/2025.
//

import XCTest
@testable import ios_challenge_uala

final class CityViewModelTests: XCTestCase {

    @MainActor func makeViewModel() -> CityViewModel {
        let vm = CityViewModel()
        vm.cities = [
            City(country: "Argentina", name: "Buenos Aires", id: 1, coord: Coordinate(lon: 1, lat: 1)),
            City(country: "Argentina", name: "Cordoba", id: 2, coord: Coordinate(lon: 2, lat: 2)),
            City(country: "Argentina", name: "Rosario", id: 3, coord: Coordinate(lon: 3, lat: 3))
        ]
        return vm
    }

    @MainActor func testToggleFavourite() {
        let vm = makeViewModel()
        let city = vm.cities[0]

        XCTAssertFalse(vm.isFavourite(city))
        vm.toggleCityFavouriteTag(city)
        XCTAssertTrue(vm.isFavourite(city))
        vm.toggleCityFavouriteTag(city)
        XCTAssertFalse(vm.isFavourite(city))
    }

    @MainActor func testShowOnlyFavourites() {
        let vm = makeViewModel()
        let city = vm.cities[1]
        vm.toggleCityFavouriteTag(city)
        vm.showOnlyFavourites = true

        XCTAssertEqual(vm.favouriteCities.count, 1)
        XCTAssertEqual(vm.favouriteCities.first?.id, city.id)
    }

    @MainActor func testFilteredCitiesWithSearch() {
        let vm = makeViewModel()
        vm.searchText = "bue"

        let filtered = vm.filteredCities
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.name, "Buenos Aires")
    }

    @MainActor func testFilteredCitiesEmptySearch() {
        let vm = makeViewModel()
        vm.searchText = ""

        XCTAssertEqual(vm.filteredCities.count, vm.cities.count)
    }
}
