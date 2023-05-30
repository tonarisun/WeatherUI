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
//    static func fetchWeather(cityId: String) -> AnyPublisher<Forecast, Error> {
//        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&mode=json&units=metric&appid=4142e9613cb27a38a3607937f747095c") else {
//            fatalError("Invalid URL")
//        }
//
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: ListResponse.self, decoder: JSONDecoder())
//            .map({ list in
//                return Forecast(name: list.list.first?.weather.first?.main ?? "",
//                                description: list.list.first?.weather.first?.description ?? "",
//                                temperature: list.list.first?.main?.temp ?? 0,
//                                feels: list.list.first?.main?.feels_like ?? 0,
//                                maxTemp: list.list.first?.main?.temp_max ?? 0,
//                                minTemp: list.list.first?.main?.temp_min ?? 0,
//                                pressure: list.list.first?.main?.pressure ?? 0,
//                                humidity: list.list.first?.main?.humidity ?? 0,
//                                windDegree: list.list.first?.wind.deg ?? 0,
//                                windSpeed: list.list.first?.wind.speed ?? 0,
//                                sunrise: list.city?.sunrise ?? 0,
//                                sunset: list.city?.sunset ?? 0,
//                                timezone: list.city?.timezone ?? 0)
//            })
//            .eraseToAnyPublisher()
//    }
    
    func fetchCurrentWeatherAsync(cityId: Int) async -> Result<CurrentWeather, WeatherFetcherError> {
        guard let url = URL(string: "\(baseURL)weather?id=\(cityId)&mode=json&units=\(UserDefaults.unitSystem)&appid=\(appid)") else {
            return .failure(.missingUrl)
        }
        let request = URLRequest(url: url, timeoutInterval: 30)
        do {
            let (data1, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let weather = try? JSONDecoder().decode(WeatherResponse.self, from: data1) else {
                return .failure(.requestFailed)
            }
            let currentWeather = CurrentWeather(with: weather)
            return .success(currentWeather)
        }
        catch {
            return .failure(.requestFailed)
        }
    }
    
    func fetchForecastAsync(cityId: Int) async -> Result<[Forecast], WeatherFetcherError> {
        guard let url = URL(string: "\(baseURL)forecast?id=\(cityId)&mode=json&units=\(UserDefaults.unitSystem)&appid=\(appid)") else {
            return .failure(.missingUrl)
        }
        let request = URLRequest(url: url, timeoutInterval: 30)
        do {
            let (data1, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let list = try? JSONDecoder().decode(ListResponse.self, from: data1) else {
                return .failure(.requestFailed)
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
            return .success(forecast)
        }
        catch {
            return .failure(.requestFailed)
        }
    }
}
