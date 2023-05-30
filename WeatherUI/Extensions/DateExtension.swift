//
// WeatherUI
//
// DateExtension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

enum DateComponentType {
    
    case timeFull
    case weekDay
    case shortDate
    case hour
    
    var template: String {
        switch self {
        case .timeFull:
            return "HH:mm:ss"
        case .weekDay:
            return "EEEE"
        case .shortDate:
            return "dd.MM"
        case .hour:
            return "HH"
        }
    }
}

extension Date {
    
    static func getDateString(time: Int, type: DateComponentType) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = type.template
        return dateFormatter.string(from: date)
    }
    
    static func getTimeInt(date: Int) -> Int {
        let stringValue = Date.getDateString(time: date, type: .hour)
        return Int(stringValue)!
    }
}
