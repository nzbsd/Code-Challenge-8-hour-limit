//
//  StarshipViewModel.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation
import Observation

@Observable
class StarshipViewModel {
    
    var starshipResult: StarshipResult?
    var starships: [Starship] = []
    
    /// Pilot Scanning
    var pilotScanningProgress: Int = 0
    var pilotStatus: FetchingStatus = .loading
    
    /// Pilot Scanning
    var filmScanningProgress: Int = 0
    var filmStatus: FetchingStatus = .loading
    
    init() {
        Task { try await getStarshipData("https://swapi.dev/api/starships/?format=json") }
    }
    
    func getStarshipData(_ url: String) async throws {
        do {
            self.starshipResult = try await DataService.shared.fetchJsonData(for: StarshipResult.self, from: url)
            guard let result = starshipResult?.results else { return }
            self.starships = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getPrevPage() async throws {
        do {
            self.starships = []
            let prevPage = try await DataService.shared.fetchJsonData(for: StarshipResult.self, from: starshipResult?.previous ?? "")
            self.starshipResult = prevPage
            guard let result = starshipResult?.results else { return }
            self.starships = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getNextPage() async throws {
        do {
            self.starships = []
            let nextPage = try await DataService.shared.fetchJsonData(for: StarshipResult.self, from: starshipResult?.next ?? "")
            self.starshipResult = nextPage
            guard let result = starshipResult?.results else { return }
            self.starships = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getStarshipPilots(_ starship: Starship) async throws -> [Character] {
        pilotScanningProgress = 0
        guard !starship.pilots.isEmpty else {
            pilotStatus = .noItemsFound
            return []
        }
        
        var pilots: [Character] = []
        pilotStatus = .loading
        
        for pilot in starship.pilots {
            pilotScanningProgress += 1
            pilots.append(try await DataService.shared.fetchJsonData(for: Character.self, from: pilot))
        }
        
        pilotStatus = .finished
        return pilots
    }
    
    func getStarshipFilms(_ starship: Starship) async throws -> [Film] {
        filmScanningProgress = 0
        guard !starship.films.isEmpty else {
            filmStatus = .noItemsFound
            return []
        }
        
        var films: [Film] = []
        filmStatus = .loading
        
        for film in starship.films {
            filmScanningProgress += 1
            films.append(try await DataService.shared.fetchJsonData(for: Film.self, from: film))
        }
        
        filmStatus = .finished
        return films
    }
    
}
