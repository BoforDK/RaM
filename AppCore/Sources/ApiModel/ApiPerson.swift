//
//  ApiPerson.swift
//  AppCore
//
//  Created by Alexander Grigorov on 10.01.2025.
//

public struct ApiPerson: Decodable {

    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: ApiLocation
    public let location: ApiLocation
    public let image: String
}
