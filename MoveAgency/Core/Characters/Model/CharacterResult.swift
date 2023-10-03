//
//  CharacterResult.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation

struct CharacterResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Character]
}
