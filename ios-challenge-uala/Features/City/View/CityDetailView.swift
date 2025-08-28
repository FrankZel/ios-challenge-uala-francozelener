//
//  CityDetailView.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 28/08/2025.
//

import SwiftUI

struct CityDetailView: View {
    @State var viewModel: CityDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            let city = viewModel.cityDetails?.data?.first
            Text(city?.name ?? "")
                .font(.title)
                .bold()

            HStack {
                Label(city?.country ?? "", systemImage: "globe")
                Spacer()
                Label(city?.region ?? "", systemImage: "map")
            }
            .font(.subheadline)

            HStack {
                Label("Population", systemImage: "person.3.fill")
                Spacer()
                Text("\(city?.population ?? 0)")
            }
            .font(.subheadline)
        }
        .padding()
        .roundedBackground()
    }
}

#Preview {
    let mockCityResponse = CityDetailsModel(
        links: [
            Link(rel: "first", href: "/v1/geo/cities?offset=0&limit=5&location=-34.606633-58.34"),
            Link(rel: "next", href: "/v1/geo/cities?offset=5&limit=5&location=-34.606633-58.34"),
            Link(rel: "last", href: "/v1/geo/cities?offset=285&limit=5&location=-34.606633-58.34")
        ],
        data: [
            CityDetail(
                id: 3009439,
                wikiDataId: "Q781553",
                type: "ADM2",
                city: "Puerto Madero",
                name: "Puerto Madero",
                country: "Argentina",
                countryCode: "AR",
                region: "Buenos Aires",
                regionCode: "C",
                regionWdId: "Q1486",
                latitude: -34.60944,
                longitude: -58.36186,
                population: 6726,
                distance: 1.26
            ),
            CityDetail(
                id: 3089290,
                wikiDataId: "Q1026688",
                type: "ADM2",
                city: "San Telmo",
                name: "San Telmo",
                country: "Argentina",
                countryCode: "AR",
                region: "Buenos Aires",
                regionCode: "C",
                regionWdId: "Q1486",
                latitude: -34.62,
                longitude: -58.37122,
                population: 20453,
                distance: 2.0
            )
        ],
        metadata: Metadata(
            currentOffset: 0,
            totalCount: 289
        )
    )
    
//    CityDetailView(city: mockCityResponse)
}
