//
//  DataService.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import Foundation

enum FetchingErrors: Error {
    case invalidURL
    case decodingError
    
    var localizedDescription: String {
        switch self {
            
        case .invalidURL:
            "Invalid Url"
        case .decodingError:
            "Error while decoding"
        }
    }
}

class DataService {
    
    static let shared = DataService()
    
    private init() { }
    
    func fetchJsonData<T: Codable>(for type: T.Type, from url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            print(FetchingErrors.invalidURL.localizedDescription)
            throw FetchingErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw FetchingErrors.decodingError
        }
        
    }
    
}
