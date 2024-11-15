//
//  CharactersPage.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

public struct CharactersPage: Decodable {

    public let info: PageInfo
    public let results: [Person]

    public init(
        info: PageInfo,
        results: [Person]
    ) {
        self.info = info
        self.results = results
    }
}
