//
//  ContentView.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            FilmListView()
                .tabItem { Label("Films", systemImage: "film.stack") }
            StarshipListView()
                .tabItem { Label("Starships", systemImage: "train.side.front.car") }
            CharactersListView()
                .tabItem { Label("Characters", systemImage: "person") }
        }
    }
}

#Preview {
    ContentView()
}
