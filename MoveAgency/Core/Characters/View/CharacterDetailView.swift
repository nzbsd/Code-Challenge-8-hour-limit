//
//  CharacterDetailView.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    var vm: CharacterViewModel
    var character: Character
    @State var films: [Film] = []
    @State var starships: [Starship] = []
    @State var filmCount: Int = 0
    @State var shipCount: Int = 0
    
    
    var body: some View {
        List {
            Section("Profile") {
                HStack {
                    Text("Name")
                        .bold()
                    Spacer()
                    Text(character.name)
                }
                HStack {
                    Text("Height")
                        .bold()
                    Spacer()
                    Text("\(character.height) cm")
                }
                HStack {
                    Text("Mass")
                        .bold()
                    Spacer()
                    Text("\(character.mass) kg")
                }
                HStack {
                    Text("Hair Color")
                        .bold()
                    Spacer()
                    Text(character.hairColor.capitalized)
                }
                HStack {
                    Text("Eye Color")
                        .bold()
                    Spacer()
                    Text(character.eyeColor.capitalized)
                }
                HStack {
                    Text("Gender")
                        .bold()
                    Spacer()
                    Text(character.gender?.rawValue.capitalized ?? "N/A")
                }
            }
            Section("🎥 \(filmCount) Films") {
                switch vm.filmScanningStatus {
                case .noItemsFound:
                    Text("This character did not appear in any films.")
                case .loading:
                    HStack {
                        ProgressView()
                        Text(" Scanning for films")
                    }
                case .finished:
                    ForEach(films) { film in
                        Text(film.title)
                    }
                }
            }.contentTransition(.numericText())
            Section("🚀 \(shipCount) Spaceships") {
                switch vm.shipScanningStatus {
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
        .onChange(of: vm.shipScanningProgress, { _, newValue in
            withAnimation(.snappy) {
                shipCount = newValue
            }
        })
        .onChange(of: vm.filmScanningProgress, { _, newValue in
            withAnimation(.snappy) {
                filmCount = newValue
            }
        })
        .navigationBarTitle(character.name, displayMode: .inline)
        .onAppear {
            Task { self.films = try await vm.getCharacterFilms(character) }
            Task { self.starships = try await vm.getCharacterShips(character) }
        }
    }
}
#Preview {
    NavigationStack {
        CharacterDetailView(vm: CharacterViewModel(), character: MockCharacter.character, films: [])
    }
}
