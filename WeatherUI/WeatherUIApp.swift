//
// WeatherUI
//
// WeatherUIApp
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

@main
struct WeatherUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainContentView(viewModel: MainViewModel())
        }
    }
}
