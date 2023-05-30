//
// WeatherUI
//
// SearchContentView
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftUI

struct SearchContentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var inputText: String = ""
    @ObservedObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return NavigationView {
            VStack {
                TextField(text: $inputText) {
                    Text("Search city...")
                        .foregroundColor(.white)
                        .font(Font.body.weight(.ultraLight))
                }
                    .font(Font.body.weight(.light))
                    .onChange(of: inputText) { newValue in
                        viewModel.filterCities(text: newValue)
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .textFieldStyle(CustomTextFieldStyle())
                    .tint(.white)
                    .foregroundColor(.white)
                
                if viewModel.showingCities.isEmpty {
                    Text("Nothing found, please try another request")
                        .foregroundColor(.white)
                        .fontWeight(.light)
                        .padding()
                }
                ScrollView(.vertical) {
                    Spacer().frame(height: 20)
                    ForEach(viewModel.showingCities) { item in
                        CityCell(item: item) {
                            viewModel.saveSelectedCity(item)
                            dismiss()
                        }
                    }
                }
            }
            .background(Color.backgroundBlue)
        }
    }
}

struct SearchContentView_Previews: PreviewProvider {
    static var previews: some View {
        var cities = [City]()
        for i in 1...1000 {
            cities.append(City(id: i, name: "City\(i)", state: "ST", country: "CT", coordinate: Coordinate(lat: Double(i), lon: Double(i+1))))
        }
        return SearchContentView(viewModel: SearchViewModel(delegate: nil, cities: cities))
    }
}
