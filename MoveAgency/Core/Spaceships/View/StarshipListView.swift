//
//  StarshipListView.swift
//  MoveAgency
//
//  Created by Max Versteeg on 30/09/2023.
//

import SwiftUI

struct StarshipListView: View {
    
    var vm = StarshipViewModel()
    @State var search: String = ""
    @State var showFav: Bool = false
    
    var searchShips: [Starship] {
        
        var favShips: [Starship] {
            if showFav == true {
                return vm.starships.filter( {$0.isFav == true} )
            } else {
                return vm.starships
            }
        }
        
        if search.isEmpty {
            return favShips
        } else {
            return favShips.filter( { $0.name.lowercased().contains(search.lowercased()) })
        }
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        if !vm.starships.isEmpty {
                            ForEach(searchShips) { starship in
                                NavigationLink {
                                    StarshipDetailView(starship: starship, vm: vm)
                                } label: {
                                    VStack(alignment: .leading) {
                                        // MARK: Title & Fav
                                        HStack {
                                            Text(starship.name)
                                                .font(.title3.bold())
                                            Spacer()
                                            Button {
                                                if let index = vm.starships.firstIndex(where: { $0.id == starship.id }) {
                                                    vm.starships[index].isFav.toggle()
                                                }
                                            } label: {
                                                Image(systemName: starship.isFav ? "star.fill" : "star")
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
            .navigationTitle("Starships")
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
                        .disabled(vm.starshipResult?.previous == nil)
                        
                        
                        Button {
                            Task { try await vm.getNextPage() }
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                        .disabled(vm.starshipResult?.next == nil)
                    }
                }
                
            }
        }
    }
}

#Preview {
    StarshipListView()
}
