//
//  CharacterViewModle.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation
import Observation

@Observable
class CharacterViewModel {
    
    /// Starship Scanning
    var characterResult: CharacterResult?
    var characters: [Character] = []
    
    /// Film Scanning
    var filmScanningProgress: Int = 0
    var filmScanningStatus: FetchingStatus = .loading
    
    /// Ship Scanning
    var shipScanningProgress: Int = 0
    var shipScanningStatus: FetchingStatus = .loading
    
    
    init() {
        Task { try await getCharacterData("https://swapi.dev/api/people/?page=1&format=json") }
    }
    
    func getCharacterData(_ url: String) async throws {
        do {
            self.characterResult = try await DataService.shared.fetchJsonData(for: CharacterResult.self, from: url)
            guard let result = characterResult?.results else { return }
            self.characters = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getPrevPage() async throws {
        do {
            self.characters = []
            let prevPage = try await DataService.shared.fetchJsonData(for: CharacterResult.self, from: characterResult?.previous ?? "")
            self.characterResult = prevPage
            guard let result = characterResult?.results else { return }
            self.characters = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getNextPage() async throws {
        do {
            self.characters = []
            let nextPage = try await DataService.shared.fetchJsonData(for: CharacterResult.self, from: characterResult?.next ?? "")
            self.characterResult = nextPage
            guard let result = characterResult?.results else { return }
            self.characters = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCharacterFilms(_ character: Character) async throws -> [Film] {
        filmScanningProgress = 0
        guard !character.films.isEmpty else {
            filmScanningStatus = .noItemsFound
            return []
        }
        
        var films: [Film] = []
        filmScanningStatus = .loading
        
        for film in character.films {
            filmScanningProgress += 1
            films.append(try await DataService.shared.fetchJsonData(for: Film.self, from: film))
        }
        filmScanningStatus = .finished
        return films
    }
    
    func getCharacterShips(_ character: Character) async throws -> [Starship] {
        shipScanningProgress = 0
        guard !character.starships.isEmpty else {
            shipScanningStatus = .noItemsFound
            return []
        }
        
        var ships: [Starship] = []
        shipScanningStatus = .loading
        
        for ship in character.starships {
            shipScanningProgress += 1
            ships.append(try await DataService.shared.fetchJsonData(for: Starship.self, from: ship))
        }
        shipScanningStatus = .finished
        return ships
    }
    
}

enum FetchingStatus {
    case noItemsFound
    case loading
    case finished
}
