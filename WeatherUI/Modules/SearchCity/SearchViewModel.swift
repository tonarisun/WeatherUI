//
// WeatherUI
//
// SearchViewModel
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Combine

class SearchViewModel: ObservableObject {
    private let delegate: CitySelectionDelegate?
    private var cities: [City] = []
    private var randomCities = [City]()
    @Published var showingCities: [City] = []
    
    init(delegate: CitySelectionDelegate?, cities: [City]) {
        self.cities = cities
        self.randomCities = cities.random(100)
        self.showingCities = randomCities
        self.delegate = delegate
    }

    func filterCities(text: String) {
        if text.isEmpty {
            showingCities = randomCities.compactMap({ $0 })
        }
        if text.count > 2 {
            showingCities = cities.filter({ $0.name.lowercased().contains(text.lowercased()) })
        }
    }
    
    func saveSelectedCity(_ city: City?) {
        delegate?.citySelected(city)
    }
}

protocol CitySelectionDelegate {
    func citySelected(_ city: City?)
}
