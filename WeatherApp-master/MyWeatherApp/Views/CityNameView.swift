//
//  CityNameView.swift
//  MyWeatherApp
//
//  Created by Geethanjali GV on 19/12/2021.
//

import SwiftUI

struct CityNameView: View {
    var city: String
    var date: String
    var body: some View {
        HStack{
            VStack(alignment: .center, spacing: 10) {
                Text(city)
                    .font(.title)
                    .bold()
                Text(date)
            }.foregroundColor(.white)
        }
    }
}

struct CityNameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
