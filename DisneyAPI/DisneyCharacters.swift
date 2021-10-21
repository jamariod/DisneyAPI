//
//  DisneyCharacters.swift
//  DisneyAPI
//
//  Created by Jamario Davis on 10/20/21.
//

import Foundation

struct DisneyData: Codable {
    let data: [DisneyCharacters]
}
struct DisneyCharacters: Codable {
    let name: String
    let imageUrl: String
}

extension DisneyData {
    
    static func getCharacters() -> [DisneyCharacters] {
        var characterInfo = [DisneyCharacters]()
        
        guard let fileURL = Bundle.main.url(forResource: "disney-characters", withExtension: "json") else {
            fatalError("Could not locate json file")
        }
        do {
            let mydata = try Data(contentsOf: fileURL)
            let charactersData = try JSONDecoder().decode(DisneyData.self, from: mydata)
            characterInfo = charactersData.data
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return characterInfo
    }
}
