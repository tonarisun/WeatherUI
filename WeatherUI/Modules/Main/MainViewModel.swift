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
    @Published var currentCity: City
    @Published var nowForecast: CurrentWeather?
    @Published var dailyForecast: [DailyForecast] = []
    @Published var loadInProgress: Bool = false
    
    init() {
        loadInProgress = true
        fetcher = WeatherFetcher()
        cityHelper = CityHelper()
        currentCity = cityHelper.cities.first(where: { $0.id == UserDefaults.currentCityId }) ?? City(id: 1235846, name: "Matara", state: "", country: "LK", coordinate: Coordinate(lat: 5.94851, lon: 80.535278))
        fetchWeather()
    }
    
    func fetchWeather() {
        loadInProgress = true
        Task(priority: .high, operation: {
            let forecastResponse = await fetcher.fetchForecastAsync(cityId: currentCity.id)
            let currentWeatherResponse = await fetcher.fetchCurrentWeatherAsync(cityId: currentCity.id)
            await MainActor.run {
                if case .success(let forecast) = forecastResponse {
                    ForecastHelper.dateForWeatherItems(weathersList: forecast)
                    self.dailyForecast = self.createDailyForecast(ForecastHelper.sortWeatherByDay(weatherList: forecast))
                }
                if case .success(let weather) = currentWeatherResponse {
                    self.nowForecast = weather
                }
                self.loadInProgress = false
            }
        })
//        fetcher.fetchWeather(cityId: "\(currentCity.id)") { [weak self] forecast in
//            guard let self = self else { return }
//            let weather = CurrentWeather(with: forecast[0])
            
//            let day = Date.getTimeInt(date: weather.sunrise + weather.timezone)
//            let night = Date.getTimeInt(date: weather.sunset + weather.timezone)
//            CurrentCityTime.instance.day = ForecastHelper.correctTime(time: day)
//            CurrentCityTime.instance.night = ForecastHelper.correctTime(time: night)
//
//            ForecastHelper.dateForWeatherItems(weathersList: forecast)
//
//            self.nowForecast = weather
//            self.dailyForecast = self.createDailyForecast(ForecastHelper.sortWeatherByDay(weatherList: Array(forecast.dropFirst())))
//            self.loadInProgress = false
//        }
    }
    
    func searchCity() -> SearchContentView {
        let searchModel = SearchViewModel(delegate: self, cities: cityHelper.cities)
        return SearchContentView(viewModel: searchModel)
    }
    
    func toggleUnits(isMetric: Bool) {
        UserDefaults.unitSystem = isMetric ? UnitSystem.metric.rawValue : UnitSystem.imperial.rawValue
        fetchWeather()
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
