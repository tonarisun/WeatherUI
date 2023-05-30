//
// WeatherUI
//
// Weather
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

struct ListResponse: Decodable {
    let list: [ForecastResponse]
    let city: Sun?
}

struct WeatherResponse: Decodable {
    let main: Main?
    let wind: Wind?
    let sys: Sun?
    let weather: [Weather]
    let dt: Int?
    let timezone: Int?
}

struct ForecastResponse: Decodable {
    let main: Main?
    let wind: Wind?
    let weather: [Weather]
    let dt: Int?
    let dt_txt: String?
}

struct Main: Decodable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Int?
}

struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
}

struct Sun: Decodable {
    let sunrise: Int?
    let sunset: Int?
    let timezone: Int?
}

struct Sys: Decodable {
    let sunrise: Int?
    let sunset: Int?
}

struct Weather: Decodable {
    let main: String?
    let description: String?
}
