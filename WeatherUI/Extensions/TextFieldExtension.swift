//
// WeatherUI
//
// TextFieldExtension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.dayBlue)
            .cornerRadius(10)
            .shadow(color: .dayBlue, radius: 3)
    }
}
