//
//  Location.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

public struct Location: Decodable {

    public let name: String

    public init(
        name: String
    ) {
        self.name = name
    }
}
