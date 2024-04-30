//
//  ContentView.swift
//  MyWeatherApp
//
//  Created by Geethanjali GV on 17/12/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityVM = CityViewViewModel()
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing:0) {
            MenuHeaderView(cityVM: cityVM)
                ScrollView(showsIndicators: false){
                    CityView(cityVM: cityVM)
                }
            } .padding(.top, 30)
        } .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
