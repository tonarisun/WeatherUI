//
// WeatherUI
//
// MainContentView
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

struct MainContentView: View {
    @State private var showingSearch = false
    @State private var isMetricSystem = UserDefaults.unitSystem == UnitSystem.metric.rawValue
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if let forecast = viewModel.nowForecast {
                    ScrollView(.vertical) {
                        Spacer().frame(height: 100)
                        VStack(alignment: .leading) {
                            MainForecastView(forecast: forecast)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            DailyForecastContainerView(forecastItems: viewModel.dailyForecast)
                                .padding(.top, 20)
                        }
                    }
                    .background(Color.blueGradient)
                    HStack(alignment: .top) {
                        Text(viewModel.currentCity.name)
                            .custom(.light, size: 40)
                            .padding(.leading, 20)
                        Spacer()
                        VStack(spacing: 18) {
                            Button {
                                viewModel.fetchWeather()
                            } label: {
                                Image(systemName: "arrow.clockwise")
                            }
                            .makeCircle()
                            .padding(.trailing, 20)
                            Button {
                                isMetricSystem.toggle()
                                viewModel.toggleUnits(isMetric: isMetricSystem)
                            } label: {
                                Text(isMetricSystem ? "F°" : "C°")
                                    .custom()
                            }
                            .makeCircle()
                            .padding(.trailing, 20)
                            Button {
                                showingSearch.toggle()
                            } label: {
                                Image(systemName: "location")
                            }
                            .sheet(isPresented: $showingSearch) {
                                viewModel.searchCity()
                            }
                            .makeCircle()
                            .padding(.trailing, 20)
                        }
                        
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                if viewModel.loadInProgress {
                    ProgressView()
                        .scaleEffect(2)
                        .frame(width: 999, height: 999)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .background(Color.blueGradient)
                }
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(viewModel: MainViewModel())
    }
}
