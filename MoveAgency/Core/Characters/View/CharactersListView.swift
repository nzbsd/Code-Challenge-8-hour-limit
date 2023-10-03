//
//  CharactersListView.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import SwiftUI

struct CharactersListView: View {
    
    var vm = CharacterViewModel()
    @State var search: String = ""
    @State var showFav: Bool = false
    
    var searchCharacters: [Character] {
        
        var favChars: [Character] {
            if showFav == true {
                return vm.characters.filter( {$0.isFav == true} )
            } else {
                return vm.characters
            }
        }
        
        if search.isEmpty {
            return favChars
        } else {
            return favChars.filter( { $0.name.lowercased().contains(search.lowercased()) })
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        if !vm.characters.isEmpty {
                            ForEach(searchCharacters) { char in
                                NavigationLink {
                                    CharacterDetailView(vm: vm, character: char, films: [])
                                } label: {
                                    VStack(alignment: .leading) {
                                        // MARK: Title & Fav
                                        HStack {
                                            Text(char.name)
                                                .font(.title3.bold())
                                            Spacer()
                                            Button {
                                                if let index = vm.characters.firstIndex(where: { $0.id == char.id }) {
                                                    vm.characters[index].isFav.toggle()
                                                }
                                            } label: {
                                                Image(systemName: char.isFav ? "star.fill" : "star")
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
            }
            .navigationTitle("Characters")
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
                            Task { try await vm.getPrevPage() }
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .disabled(vm.characterResult?.previous == nil)
                        
                        
                        Button {
                            Task { try await vm.getNextPage() }
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                        .disabled(vm.characterResult?.next == nil)
                        
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    CharactersListView()
}
