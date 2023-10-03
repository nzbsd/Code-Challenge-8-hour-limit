//
//  StarshipDetailView.swift
//  MoveAgency
//
//  Created by Max Versteeg on 30/09/2023.
//

import SwiftUI

struct StarshipDetailView: View {
    
    var starship: Starship
    var vm: StarshipViewModel
    
    @State var films: [Film] = []
    @State var pilots: [Character] = []
    @State var pilotCount: Int = 0
    @State var filmCount: Int = 0
    
    var body: some View {
        List {
            
            Section("Info") {
                HStack {
                    Text("Name")
                        .bold()
                    Text(starship.name)
                }
                HStack {
                    Text("Crew")
                        .bold()
                    Text(starship.crew)
                }
                HStack {
                    Text("Consumables")
                        .bold()
                    Text(starship.consumables)
                }
            }
            
            Section("Technical Data") {
                HStack {
                    Text("Cargo Capacity")
                        .bold()
                    Text(starship.cargoCapacity)
                }
                HStack {
                    Text("Hyperdrive Rating")
                        .bold()
                    Text(starship.hyperdriveRating)
                }
            }
            DisclosureGroup("🎥 \(filmCount) Films") {
                switch vm.filmStatus {
                case .noItemsFound:
                    Text("This starship doesn't appear in any films.")
                case .loading:
                    HStack {
                        ProgressView()
                        Text("Scanning for films 🎥")
                    }
                case .finished:
                    ForEach(films) { film in
                        Text(film.title)
                        
                    }
                }
            }.contentTransition(.numericText())
            DisclosureGroup("🧑🏾‍🚀 \(pilotCount) Pilots") {
                switch vm.pilotStatus {
                case .noItemsFound:
                    Text("No pilots found for this spaceship.")
                case .loading:
                    HStack {
                        ProgressView()
                        Text("Scanning for Pilots 🧑🏾‍🚀")
                    }
                case .finished:
                    ForEach(pilots) { pilot in
                        Text(pilot.name)
                    }
                }
            }.contentTransition(.numericText())
            
            
        }.onChange(of: vm.pilotScanningProgress, { _, newValue in
            withAnimation(.snappy) {
                pilotCount = newValue
            }
        })
        .onChange(of: vm.filmScanningProgress, { _, newValue in
            withAnimation(.snappy) {
                filmCount = newValue
            }
        })
        .navigationBarTitle(starship.name, displayMode: .inline)
        .onAppear {
            Task { self.pilots = try await vm.getStarshipPilots(starship) }
            Task { self.films = try await vm.getStarshipFilms(starship) }
        }
    }
}

//#Preview {
//    StarshipDetailView()
//}
