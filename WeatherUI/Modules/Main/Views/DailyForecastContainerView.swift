//
// WeatherUI
//
// DailyForecastContainerView
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

struct DailyForecastContainerView: View {
    var forecastItems: [DailyForecast]
    
    init(forecastItems: [DailyForecast]) {
        self.forecastItems = forecastItems
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                Spacer().frame(width: 6)
                ForEach(forecastItems) {
                    DailyForecastView(forecast: $0)
                }
                Spacer().frame(width: 6)
            }
        }
    }
}
