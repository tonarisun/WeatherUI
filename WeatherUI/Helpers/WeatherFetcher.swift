//
// WeatherUI
//
// WeatherFetcher
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation
import Combine

enum WeatherFetcherError: Error {
    case missingUrl
    case requestFailed
}

class WeatherFetcher {
    let baseURL = "https://api.openweathermap.org/data/2.5/"
    let appid = "4142e9613cb27a38a3607937f747095c"

    func fetchCurrentWeatherAsync(cityId: Int) async throws -> CurrentWeather {
        guard let url = URL(string: "\(baseURL)weather?id=\(cityId)&mode=json&units=\(UserDefaults.unitSystem)&appid=\(appid)") else {
            throw WeatherFetcherError.missingUrl
        }
        let request = URLRequest(url: url, timeoutInterval: 30)
        do {
            let (data1, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let weather = try? JSONDecoder().decode(WeatherResponse.self, from: data1) else {
                throw WeatherFetcherError.requestFailed
            }
            let currentWeather = CurrentWeather(with: weather)
            return currentWeather
        }
        catch {
            throw WeatherFetcherError.requestFailed
        }
    }
    
    func fetchForecastAsync(cityId: Int) async throws -> [Forecast] {
        guard let url = URL(string: "\(baseURL)forecast?id=\(cityId)&mode=json&units=\(UserDefaults.unitSystem)&appid=\(appid)") else {
            throw WeatherFetcherError.missingUrl
        }
        let request = URLRequest(url: url, timeoutInterval: 30)
        do {
            let (data1, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let list = try? JSONDecoder().decode(ListResponse.self, from: data1) else {
                throw WeatherFetcherError.requestFailed
            }
            let forecast = list.list.map { item -> Forecast in
                Forecast(name: item.weather.first?.main ?? "",
                         description: item.weather.first?.description ?? "",
                         temperature: NSString(format:"%.1f", item.main?.temp ?? 0) as String,
                         feels: NSString(format:"%.1f", item.main?.feels_like ?? 0) as String,
                         maxTemp: item.main?.temp_max ?? 0,
                         minTemp: item.main?.temp_min ?? 0,
                         pressure: Int((item.main?.pressure ?? 0) / 1.333),
                         humidity: item.main?.humidity ?? 0,
                         windDegree: item.wind?.deg ?? 0,
                         windSpeed: NSString(format:"%.1f", item.wind?.speed ?? 0) as String,
                         sunrise: list.city?.sunrise ?? 0,
                         sunset: list.city?.sunset ?? 0,
                         timezone: list.city?.timezone ?? 0,
                         dateText: item.dt_txt ?? "",
                         dateInt: item.dt ?? 0)
            }
            return forecast
        }
        catch {
            throw WeatherFetcherError.requestFailed
        }
    }
}
