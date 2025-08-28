//
//  WeatherViewOnMap.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 28/08/2025.
//

import SwiftUI

struct WeatherViewOnMap: View {
    
    @State var cityWeather: WeatherModel?
    var viewModel : WeatherViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(Int(viewModel.weather?.main?.temp?.rounded() ?? 0))°")
            if let iconURL = viewModel.getIconUrl() {
                AsyncImage(url: iconURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            
            Text(viewModel.weather?.weather?.first?.description?.capitalized ?? "No value")
        }
        .roundedBackground()
        
    }
}

struct RoundedBackgroundModifier: ViewModifier {
    var cornerRadius: CGFloat = 12
    var backgroundColor: Color = .black
    var opacity: Double = 0.3

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .opacity(opacity)
                    .shadow(radius: 4)
            )
    }
}

extension View {
    func roundedBackground(
        cornerRadius: CGFloat = 12,
        backgroundColor: Color = .black,
        opacity: Double = 0.3
    ) -> some View {
        self.modifier(RoundedBackgroundModifier(
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor,
            opacity: opacity
        ))
    }
}
