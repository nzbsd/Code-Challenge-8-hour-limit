//
//  Character.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation

struct Character: Identifiable, Codable {
    let id = UUID()
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let gender: Gender?
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String
    var isFav: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

struct MockCharacter {
    static let character = Character(name: "Anakin Skywalker",
                                     height: "188",
                                     mass: "84",
                                     hairColor: "blond",
                                     skinColor: "fair",
                                     eyeColor: "blue",
                                     birthYear: "41.9BBY",
                                     gender: .male,
                                     homeworld: "https://swapi.dev/api/planets/1/",
                                     films: [
                                        "https://swapi.dev/api/films/4/",
                                        "https://swapi.dev/api/films/5/",
                                        "https://swapi.dev/api/films/6/"
                                     ],
                                     species: [],
                                     vehicles: [
                                        "https://swapi.dev/api/vehicles/44/",
                                        "https://swapi.dev/api/vehicles/46/"
                                     ],
                                     starships: [
                                        "https://swapi.dev/api/starships/39/",
                                        "https://swapi.dev/api/starships/59/",
                                        "https://swapi.dev/api/starships/65/"
                                     ],
                                     created: "2014-12-10T16:20:44.310000Z",
                                     edited: "2014-12-20T21:17:50.327000Z",
                                     url: "https://swapi.dev/api/people/11/")
}
