//
// WeatherUI
//
// ImageExtension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

extension Image {
    static func weatherImage(description: String, isDay: Bool) -> Image {
        let image: Image
        switch description {
        case "Clouds": image = isDay ? Image("cloudy-day") : Image("cloudy-night")
        case "Clear": image = isDay ? Image("sun") : Image("clear-night")
        case "Rain", "Drizzle": image = isDay ? Image("rain-day") : Image("rain-night")
        case "Snow": image = isDay ? Image("snow-day") : Image("snow-night")
        case "Thunderstorm": image = isDay ? Image("storm-day") : Image("storm-night")
        case "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash": image = isDay ? Image("foggy-day") : Image("foggy-night")
        case "Tornado": image = Image("hurricane")
        case "Squall": image = isDay ? Image("windy-day") : Image("windy-night")
        default: image = isDay ? Image("cloudy-day") : Image("cloudy-night")
        }
        return image.resizable()
    }

    static func windImage(degree: Int) -> Image {
        let image: Image
        switch degree {
        case 0...15, 345...361:
            image = Image("wind-north")
        case 16...75:
            image = Image("wind-north-east")
        case 76...105:
            image = Image("wind-east")
        case 106...165:
            image = Image("wind-south-east")
        case 166...195:
            image = Image("wind-south")
        case 196...255:
            image = Image("wind-south-west")
        case 256...285:
            image = Image("wind-west")
        case 286...345:
            image = Image("wind-north-west")
        default:
            image = Image("")
        }
        return image.resizable()
    }
}
