//
// WeatherUI
//
// ColorExtension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

extension Color {
    static let backgroundBlue = Color("main-bg")
    static let dayBlue = Color("day-bg")
    static let nightBlue = Color("night-bg")
    static let shadowBlue = Color("shadow")
    static let blueGradient = LinearGradient(colors: [Color.backgroundBlue, Color.shadowBlue], startPoint: .zero, endPoint: .bottomTrailing)
}
