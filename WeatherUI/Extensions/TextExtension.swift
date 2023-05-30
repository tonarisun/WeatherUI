//
// WeatherUI
//
// TextExtension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

extension Text {
    func custom(_ weight: Font.Weight = .regular, size: CGFloat = 20, italic: Bool = false) -> Text {
        if italic {
            return self.font(.system(size: size)).foregroundColor(.white).italic().fontWeight(weight)
        } else {
            return self.font(.system(size: size)).foregroundColor(.white).fontWeight(weight)
        }
    }
}
