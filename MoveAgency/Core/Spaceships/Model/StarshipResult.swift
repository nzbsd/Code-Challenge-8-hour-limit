//
//  StarshipResult.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation

struct StarshipResult: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Starship]
}
