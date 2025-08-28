//
//  CityCellView.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 27/08/2025.
//


import SwiftUI

struct CityCellView: View {
    
    var city: City
    var viewModel: CityViewModel
    
    @State private var animate = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                NavigationLink(value: city) {
                    VStack (alignment: .leading) {
                        Text("\(city.name), \(city.country)")
                            .font(.body)
                            .bold()
                        Text("\(city.coord.lon),\(city.coord.lat) ")
                            .font(.footnote)
                            .foregroundColor(Color(.secondaryLabel))
                    }.padding()
                }
            }
            
            Spacer()
            
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                    viewModel.toggleCityFavouriteTag(city)
                    animate.toggle()
                }
            } label: {
                Image(systemName: viewModel.isFavourite(city) ? "star.fill" : "star")
                    .scaleEffect(animate ? 1.2 : 1.0)
                    .foregroundColor(viewModel.isFavourite( city) ? .yellow : .gray)
            }
            .onChange(of: viewModel.isFavourite( city)) {
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animate = false
                }
            }
            .buttonStyle(.borderless)
            .padding()
        }
    }
}

#Preview {
    CityCellView(city: City(country: "AR", name: "Ciudad Autónoma de Buenos Aires", id: 1, coord: Coordinate(lon: -34.606633, lat: -58.435344)), viewModel: CityViewModel())
}
