//
//  FilmViewModel.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation
import Observation

@Observable
class FilmViewModel {
    
    var films: [Film] = []
    var filmResult: FilmResult?
    
    var characterScanningProgress: Int = 0
    var characterScanningStatus: FetchingStatus = .loading
    
    var starshipScanningProgress: Int = 0
    var starshipScanningStatus: FetchingStatus = .loading
    
    init() {
        Task { try await getFilmData() }
    }
    
    func getFilmData() async throws {
        do {
            let filmResult = try await DataService.shared.fetchJsonData(for: FilmResult.self, from: "https://swapi.dev/api/films/?format=json")
            self.films = filmResult.results ?? []
            self.filmResult = filmResult
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFilmCharacters(_ film: Film) async throws -> [Character] {
        characterScanningProgress = 0
        guard !film.characters.isEmpty else {
            characterScanningStatus = .noItemsFound
            return []
        }
        
        var characters: [Character] = []
        characterScanningStatus = .loading
        
        for char in film.characters {
            characterScanningProgress += 1
            characters.append(try await DataService.shared.fetchJsonData(for: Character.self, from: char))
        }
        characterScanningStatus = .finished
        return characters
    }
    
    func getFilmStarships(_ film: Film) async throws -> [Starship] {
        characterScanningProgress = 0
        guard !film.starships.isEmpty else {
            starshipScanningStatus = .noItemsFound
            return []
        }
        
        var starships: [Starship] = []
        starshipScanningStatus = .loading
        
        for starship in film.starships {
            starshipScanningProgress += 1
            starships.append(try await DataService.shared.fetchJsonData(for: Starship.self, from: starship))
        }
        starshipScanningStatus = .finished
        return starships
    }
    
}
