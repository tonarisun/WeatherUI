//
// WeatherUI
//
// Forecast
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

// MARK: - Forecast
class Forecast: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let temperature: String
    let feels: String
    let maxTemp: Double
    let minTemp: Double
    let pressure: Int
    let humidity: Int
    let windDegree: Int
    let windSpeed: String
    let sunrise: Int
    let sunset: Int
    let timezone: Int
    let dateText: String
    let dateInt: Int
    
    var timeInt = 0
    var datePretty = ""
    var weekDay = ""
    var isDay = false

    init(name: String,
         description: String,
         temperature: String,
         feels: String,
         maxTemp: Double,
         minTemp: Double,
         pressure: Int,
         humidity: Int,
         windDegree: Int,
         windSpeed: String,
         sunrise: Int,
         sunset: Int,
         timezone: Int,
         dateText: String,
         dateInt: Int) {
        self.name = name
        self.description = description
        self.temperature = temperature
        self.feels = feels
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.pressure = pressure
        self.humidity = humidity
        self.windDegree = windDegree
        self.windSpeed = windSpeed
        self.sunrise = sunrise
        self.sunset = sunset
        self.timezone = timezone
        self.dateText = dateText
        self.dateInt = dateInt
    }
}

// MARK: - CurrentWeather
class CurrentWeather {
    let name: String
    let description: String
    let temperature: String
    let feels: String
    let humidity: Int
    let windSpeed: String
    let sunrise: Int
    let sunset: Int
    let dateInt: Int
    let timezone: Int
    
    var timeInt = 0
    
    init(name: String,
         description: String,
         temperature: String,
         feels: String,
         humidity: Int,
         windSpeed: String,
         sunrise: Int,
         sunset: Int,
         dateInt: Int,
         timezone: Int) {
        self.name = name
        self.description = description
        self.temperature = temperature
        self.feels = feels
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.sunrise = sunrise
        self.sunset = sunset
        self.dateInt = dateInt
        self.timezone = timezone
    }
    
    convenience init(with weather: WeatherResponse) {
        self.init(name: weather.weather.first?.main ?? "",
                  description: weather.weather.first?.description ?? "",
                  temperature: NSString(format:"%.1f", weather.main?.temp ?? 0) as String,
                  feels: NSString(format:"%.1f", weather.main?.feels_like ?? 0) as String,
                  humidity: weather.main?.humidity ?? 0,
                  windSpeed: NSString(format:"%.1f", weather.wind?.speed ?? 0) as String,
                  sunrise: weather.sys?.sunrise ?? 0,
                  sunset: weather.sys?.sunset ?? 0,
                  dateInt: weather.dt ?? 0,
                  timezone: weather.timezone ?? 0)
    }
}

// MARK: - DailyForecast
struct DailyForecast: Identifiable {
    let id = UUID()
    var weekDay: String = ""
    var tempDay: String = ""
    var tempNight: String = ""
    var skyDay: String = ""
    var skyNight: String = ""
}
