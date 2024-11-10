//
//  Status.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

public enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
