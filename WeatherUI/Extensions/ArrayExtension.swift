//
// WeatherUI
//
// ArrayExtension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

extension Array where Element: Any {
    func random(_ count: Int) -> [Element] {
        var newArr = [Element?]()
        for _ in 0...count {
            newArr.append(self.randomElement())
        }
        return newArr.compactMap({ $0 })
    }
}
