//
//  FilmDetailView.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import SwiftUI

struct FilmDetailView: View {
    
    var film: Film
    var vm = FilmViewModel()
    
    @State var starships: [Starship] = []
    @State var shipCount: Int = 0
    
    @State var characters: [Character] = []
    @State var characterCount: Int = 0
    
    init(film: Film) {
        self.film = film
    }
    
    var body: some View {
        List() {
            Section("About") {
                VStack(alignment: .leading) {
                    Text("Directed by")
                        .bold()
                    Text(film.director)
                }
                VStack(alignment: .leading) {
                    Text("Produced by")
                        .bold()
                    Text(film.producer)
                }
                VStack(alignment: .leading) {
                    Text("Released on")
                        .bold()
                    Text(film.releaseDate)
                }
            }
            DisclosureGroup("🧑🏾‍🚀 \(characterCount) Characters") {
                switch vm.characterScanningStatus {
                case .noItemsFound:
                    Text("No characters were featured in this movie.")
                case .loading:
                    HStack {
                        ProgressView()
                        Text(" Scanning for characters")
                    }
                case .finished:
                    ForEach(characters) { char in
                        Text(char.name)
                        
                    }
                }
            }.contentTransition(.numericText())
            DisclosureGroup("🚀 \(shipCount) Spaceships") {
                switch vm.starshipScanningStatus {
                case .noItemsFound:
                    Text("This character doesn't have any spaceships.")
                case .loading:
                    HStack {
                        ProgressView()
                        Text("Scanning for spaceships 🚀")
                    }
                case .finished:
                    ForEach(starships) { ship in
                        Text(ship.name)
                        
                    }
                }
            }.contentTransition(.numericText())
        }
        .onChange(of: vm.characterScanningProgress, { _, newValue in
            withAnimation(.snappy) {
                characterCount = newValue
            }
        })
        .onChange(of: vm.starshipScanningProgress, { _, newValue in
            withAnimation(.snappy) {
                shipCount = newValue
            }
        })
        .navigationBarTitle(film.title, displayMode: .inline)
        .onAppear {
            Task { self.characters = try await vm.getFilmCharacters(film) }
        }
        .onAppear {
            Task { self.starships = try await vm.getFilmStarships(film) }
        }
        .listSectionSpacing(5)
        
    }
}

#Preview {
    NavigationStack {
        FilmDetailView(film: MockFilm.film)
    }
}
