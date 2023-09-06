//
// WeatherUI
//
// ForecastHelper
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

class CurrentCityTime {
    
    var day: Int = 0
    var night: Int = 0
    
    let defaultDay = 7
    let defaultNight = 22
    
    static let instance = CurrentCityTime()
}

class ForecastHelper {
    //MARK: - sortWeatherByDay
    func sortWeatherByDay(weatherList: [Forecast]?) -> [Forecast] {
        return weatherList?.filter({ ($0.timeInt >= 13 && $0.timeInt <= 15) || ($0.timeInt >= 1 && $0.timeInt <= 3) }) ?? []
    }

    //MARK: - correctTime
    func correctTime(time: Int) -> Int {
        var tempTime = time
        if time < 0 {
             tempTime += 24
         } else if time > 24 {
             tempTime -= 24
         }
        return tempTime
    }

    //MARK: - dateForWeatherItems
    func dateForWeatherItems(weathersList: [Forecast]) {
        weathersList.forEach { item in
            let time = item.dateInt + item.timezone
            let sunrise = Date.getTimeInt(date: item.sunrise + item.timezone)
            let sunset = Date.getTimeInt(date: item.sunset + item.timezone)
            item.datePretty = Date.getDateString(time: time, type: .shortDate)
            item.timeInt    = Date.getTimeInt(date: time)
            item.weekDay    = Date.getDateString(time: time, type: .weekDay)
            item.isDay      = item.timeInt > sunrise &&  item.timeInt <= sunset
        }
    }
}
