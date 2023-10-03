//
//  FilmListView.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import SwiftUI

struct FilmListView: View {
    
    var vm = FilmViewModel()
    @State var search: String = ""
    @State var showFav: Bool = false
    
    var searchFilms: [Film] {
        
        var favFilms: [Film] {
            if showFav == true {
                return vm.films.sorted(by: { $0.episodeID < $1.episodeID }).filter( {$0.isFav == true} )
            } else {
                return vm.films.sorted(by: { $0.episodeID < $1.episodeID })
            }
        }
        
        if search.isEmpty {
            return favFilms.sorted(by: { $0.episodeID < $1.episodeID })
        } else {
            return favFilms.filter( { $0.title.lowercased().contains(search.lowercased()) })
        }
    }
    var body: some View {
        
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        if !vm.films.isEmpty {
                            ForEach(searchFilms) { film in
                                NavigationLink {
                                    FilmDetailView(film: film)
                                } label: {
                                    VStack(alignment: .leading) {
                                        // MARK: Title & Fav
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("\(film.episodeID). \(film.title)")
                                                    .font(.title3.bold())
                                                Text("Directed by \(film.director)")
                                                    .foregroundStyle(.secondary)
                                            }
                                            Spacer()
                                            Button {
                                                if let index = vm.films.firstIndex(where: { $0.id == film.id }) {
                                                    vm.films[index].isFav.toggle()
                                                }
                                            } label: {
                                                Image(systemName: film.isFav ? "star.fill" : "star")
                                            }
                                        }
                                        
                                    }
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.ultraThinMaterial)
                                    }
                                }.buttonStyle(.plain)
                            }
                        } else {
                            ProgressView()
                        }
                    }
                    .searchable(text: $search).autocorrectionDisabled()
                    .padding()
                }
            }.navigationTitle("Films")
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showFav.toggle()
                        } label: {
                            Image(systemName: showFav ? "star.fill" : "star")
                        }
                    }
                    
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Button {
                                print("next page")
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                            .disabled(vm.filmResult?.previous == nil)
                            
                            
                            Button {
                                print("next page")
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                            .disabled(vm.filmResult?.next == nil)
                        }
                    }
                    
                }
        }
    }
}

#Preview {
    FilmListView()
}
