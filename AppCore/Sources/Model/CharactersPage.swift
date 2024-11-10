//
//  CharactersPage.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

public struct CharactersPage: Decodable {
    
    public let info: PageInfo
    public let results: [Character]
    
    public init(
        info: PageInfo,
        results: [Character]
    ) {
        self.info = info
        self.results = results
    }
}
