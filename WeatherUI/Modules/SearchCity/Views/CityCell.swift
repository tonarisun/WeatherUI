//
// WeatherUI
//
// CityCell
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

struct CityCell: View {
    
    private let item: City
    private var action: (() -> Void)?
    
    init(item: City, action: (() -> Void)?) {
        self.item = item
        self.action = action
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("\(item.name), \(item.country)")
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
        }
        .frame(height: 60)
        .onTapGesture {
            action?()
        }
    }
}
