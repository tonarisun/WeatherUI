//
// WeatherUI
//
// DailyForecastView
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

struct DailyForecastView: View {
    let forecast: DailyForecast
    
    init(forecast: DailyForecast) {
        self.forecast = forecast
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(forecast.weekDay)
                .custom(.light, size: 18)
            HStack {
                VStack(spacing: 10) {
                    Image.weatherImage(description: forecast.skyDay, isDay: true)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("\(forecast.tempDay) \(UnitSystem.signDeg)")
                        .custom(.light, size: 15, italic: true)
                }
                .padding(.horizontal, 6)
                VStack(spacing: 10) {
                    Image.weatherImage(description: forecast.skyNight, isDay: false)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("\(forecast.tempNight) \(UnitSystem.signDeg)")
                        .custom(.light, size: 15, italic: true)
                }
                .padding(.horizontal, 6)
            }
        }
        .padding()
        .shadow(color: .dayBlue, radius: 10)
//        .background(Color.nightBlue)
//        .cornerRadius(10)
    }
}

struct DailyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        return DailyForecastView(forecast: DailyForecast(weekDay: "Saturday", tempDay: "30", tempNight: "27", skyDay: "Clear", skyNight: "Cloudy")).background(Color.backgroundBlue)
    }
}
