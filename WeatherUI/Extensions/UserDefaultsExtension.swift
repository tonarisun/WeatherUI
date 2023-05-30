//
// WeatherUI
//
// UserDefaultsExtension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

enum UnitSystem: String {
    case metric = "metric"
    case imperial = "imperial"
    
    static var signDeg: String {
        switch UnitSystem(rawValue: UserDefaults.unitSystem) {
        case .metric: return "°C"
        case .imperial: return "°F"
        default: return ""
        }
    }
    
    static var signSpeed: String {
        switch UnitSystem(rawValue: UserDefaults.unitSystem) {
        case .metric: return "m/s"
        case .imperial: return "mph"
        default: return ""
        }
    }
}

extension UserDefaults {
    static var unitSystem: String {
        get {
            UserDefaults.standard.string(forKey: "unitSystem") ?? "metric"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "unitSystem")
        }
    }
    
    static var currentCityId: Int {
        get {
            UserDefaults.standard.integer(forKey: "currentCity")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentCity")
        }
    }
}
