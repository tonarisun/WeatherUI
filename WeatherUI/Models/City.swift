//
// WeatherUI
//
// City
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

struct City: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coordinate: Coordinate
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case state
        case country
        case coordinate = "coord"
    }

    func createInfoString() -> String {
        let state = state != "" ? "\(state), " : ""
        let name = "\(name), \(state)\(country)"
        return name
    }
}

struct Coordinate: Decodable {
    let lat: Double
    let lon: Double

    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}
