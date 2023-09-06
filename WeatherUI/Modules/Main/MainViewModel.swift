//
// WeatherUI
//
// MainViewModel
//
//  Created by Olga Lidman on 2023-02-01
//
//
import Foundation
import Combine

class MainViewModel: ObservableObject {
    private let fetcher: WeatherFetcher
    private let cityHelper: CityHelper
    private let forecastHelper: ForecastHelper

    @Published var currentCity: City
    @Published var nowForecast: CurrentWeather?
    @Published var dailyForecast: [DailyForecast] = []
    @Published var loadInProgress: Bool = false
    
    init() {
        fetcher = WeatherFetcher()
        cityHelper = CityHelper()
        forecastHelper = ForecastHelper()
        
        currentCity = cityHelper.cities.first(where: { $0.id == UserDefaults.currentCityId }) ?? City(id: 1235846, name: "Matara", state: "", country: "LK", coordinate: Coordinate(lat: 5.94851, lon: 80.535278))
        fetchWeather()
    }
    
    func fetchWeather() {
        loadInProgress = true
        Task(priority: .high, operation: {
            async let forecastResponse = await fetcher.fetchForecastAsync(cityId: currentCity.id)
            async let currentWeatherResponse = await fetcher.fetchCurrentWeatherAsync(cityId: currentCity.id)
            await setForecastData(forecastResponse: forecastResponse, currentWeatherResponse: currentWeatherResponse)
        })
    }
    
    func searchCity() -> SearchContentView {
        let searchModel = SearchViewModel(delegate: self, cities: cityHelper.cities)
        return SearchContentView(viewModel: searchModel)
    }
    
    func toggleUnits(isMetric: Bool) {
        UserDefaults.unitSystem = isMetric ? UnitSystem.metric.rawValue : UnitSystem.imperial.rawValue
        fetchWeather()
    }

    private func setForecastData(forecastResponse: Result<[Forecast], WeatherFetcherError>,
                        currentWeatherResponse: Result<CurrentWeather, WeatherFetcherError>) async {
        await MainActor.run {
            if case .success(let forecast) = forecastResponse {
                forecastHelper.dateForWeatherItems(weathersList: forecast)
                self.dailyForecast = self.createDailyForecast(forecastHelper.sortWeatherByDay(weatherList: forecast))
            }
            if case .success(let weather) = currentWeatherResponse {
                self.nowForecast = weather
            }
            self.loadInProgress = false
        }
    }

    private func createDailyForecast(_ forecast: [Forecast]) -> [DailyForecast] {
        var dailyForecast = [DailyForecast]()
        forecast.enumerated().forEach { index, weather in
            guard index < forecast.count-1 else { return }
            if weather.weekDay == forecast[index + 1].weekDay {
                var item = DailyForecast()
                item.weekDay = weather.weekDay
                if weather.isDay {
                    item.tempDay = weather.temperature
                    item.skyDay = weather.name
                    item.tempNight = forecast[index + 1].temperature
                    item.skyNight = forecast[index + 1].name
                } else {
                    item.tempNight = weather.temperature
                    item.skyNight = weather.name
                    item.tempDay = forecast[index + 1].temperature
                    item.skyDay = forecast[index + 1].name
                }
                dailyForecast.append(item)
            }
        }
        return dailyForecast
    }
}

extension MainViewModel: CitySelectionDelegate {
    func citySelected(_ city: City?) {
        if let city = city {
            currentCity = city
            fetchWeather()
            UserDefaults.currentCityId = city.id
        }
    }
}
