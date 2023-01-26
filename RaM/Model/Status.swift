//
//  Status.swift
//  RaM
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
