//
//  Character.swift
//  RaM
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
}
