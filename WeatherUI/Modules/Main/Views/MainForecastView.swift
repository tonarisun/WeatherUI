//
// WeatherUI
//
// MainForecastView
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

struct MainForecastView: View {
    let forecast: CurrentWeather
    
    init(forecast: CurrentWeather) {
        self.forecast = forecast
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Image.weatherImage(description: forecast.name,
                               isDay: forecast.dateInt > forecast.sunrise && forecast.dateInt < forecast.sunset)
                .resizable()
                .frame(width: 94, height: 94)
                .padding(.vertical, 10)
                .shadow(color: .dayBlue, radius: 20)
            Text(forecast.name)
                .custom(.light, size: 36)
            Text(forecast.description)
                .custom(.ultraLight, size: 20)
            Text("\(forecast.temperature) \(UnitSystem.signDeg)")
                .custom(.ultraLight, size: 67)
                .padding(.vertical, 22)
                .shadow(color: .white, radius: 15)
            HStack {
                VStack(spacing: 20) {
                    HStack {
                        Image("sunrise")
                            .resizable()
                            .frame(width: 30, height: 30)
                        let prettySunrise = Date.getDateString(time: forecast.sunrise + forecast.timezone, type: .timeFull)
                        Text(prettySunrise)
                            .custom(size: 17, italic: true)
                    }
                    HStack {
                        Image("wind-sign")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("\(forecast.windSpeed) \(UnitSystem.signSpeed)")
                            .custom(size: 17, italic: true)
                            .frame(minWidth: 55)
                    }
                }
                Spacer().frame(maxWidth: 30)
                VStack(spacing: 20)  {
                    HStack {
                        Image("sunset")
                            .resizable()
                            .frame(width: 30, height: 30)
                        let prettySunset = Date.getDateString(time: forecast.sunset  + forecast.timezone, type: .timeFull)
                        Text(prettySunset)
                            .custom(size: 17, italic: true)
                    }
                    HStack {
                        Image("humidity")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("\(forecast.humidity) %")
                            .custom(size: 17, italic: true)
                    }
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 10)
    }
}

struct MainForecastView_Previews: PreviewProvider {
    static var previews: some View {
        let weather = CurrentWeather(name: "Clouds",
                                     description: "overcast clouds",
                                     temperature: "30.1",
                                     feels: "30.4",
                                     humidity: 55,
                                     windSpeed: "10.5",
                                     sunrise: 1684241163,
                                     sunset: 1684261163,
                                     dateInt: 1684291163,
                                     timezone: 19800)
        return MainForecastView(forecast: weather).background(Color.backgroundBlue)
    }
}

