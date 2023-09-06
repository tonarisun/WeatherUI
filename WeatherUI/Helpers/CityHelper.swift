//
// WeatherUI
//
// CitiesHelper
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

class CityHelper {
    var cities = [City]()
    
    init() {
        cities = fetch()
    }
    
    private func fetch() -> [City] {
        do {
            if let bundlePath = Bundle.main.path(forResource: "city.list", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: bundlePath)
                let data = try Data(contentsOf: fileUrl)
                let decodedData = try JSONDecoder().decode([City].self, from: data)
                return decodedData
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
