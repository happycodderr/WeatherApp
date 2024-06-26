//
//  MenuHeaderView.swift
//  MyWeatherApp
//
//  Created by Geethanjali GV on 19/12/2021.
//

import SwiftUI

struct MenuHeaderView: View {
    
    @ObservedObject var cityVM:CityViewViewModel
    @State private var searchTerm = "London"
    
    var body: some View {
        HStack{
            TextField("", text:$searchTerm)
                .padding(.leading, 20)
            
            Button {
                cityVM.city = searchTerm
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0) .fill(Color.blue)
                    Image(systemName: "location.fill")
                }
            } .frame(width:50, height:50)
        } .foregroundColor(.white)
            .padding()
            .background(ZStack(alignment: .leading) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.5))
            })
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
