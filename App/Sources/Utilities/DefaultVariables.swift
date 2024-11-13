//
//  DefaultVariables.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import AppCore

struct DefaultVariables {
    static let cornerRadius: CGFloat = 10
}

let defaultCharacter: [Person] = (0..<10).map {
    Person(id: $0,
              name: "Name\($0)",
              status: convertNumberToStatus($0),
              species: "Species\($0)",
              type: "Type\($0)",
              gender: "Gender\($0)",
              origin: .init(name: "Name\($0)"),
              location: .init(name: "Name\($0)"),
              image: "Name\($0)")
}

fileprivate func convertNumberToStatus(_ number: Int) -> Status {
    if number % 3 == 0 {
        return .alive
    } else if number % 3 == 1 {
        return .dead
    } else {
        return .unknown
    }
}
