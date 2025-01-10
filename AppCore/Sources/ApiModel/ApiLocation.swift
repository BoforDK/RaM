//
//  ApiLocation.swift
//  AppCore
//
//  Created by Alexander Grigorov on 10.01.2025.
//

public struct ApiLocation: Decodable {

    public let name: String

    public init(
        name: String
    ) {
        self.name = name
    }
}
