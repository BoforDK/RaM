//
//  Person.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

//TODO: rename
public struct Person: Decodable {
    
    public let id: Int
    public let name: String
    public let status: Status
    public let species: String
    public let type: String
    public let gender: String
    public let origin: Location
    public let location: Location
    public let image: String
    
    public init(
        id: Int,
        name: String,
        status: Status,
        species: String,
        type: String,
        gender: String,
        origin: Location,
        location: Location,
        image: String
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
    }
}
