//
//  CharactersPage.swift
//  RaM
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

struct CharactersPage: Decodable {
    let info: PageInfo
    let results: [Character]
}
