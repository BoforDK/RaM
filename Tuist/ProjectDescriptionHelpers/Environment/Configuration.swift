//
//  Configuration.swift
//  ProjectDescriptionHelpers
//
//  Created by Alexander Grigorov on 29.09.2024.
//

import enum ProjectDescription.Environment

public enum Configuration: String {
    public static var current: Self {
        .init(
            rawValue: ProjectDescription.Environment.configuration
                .getString(default: Self.debug.rawValue)
        ) ?? .debug
    }

    case debug = "Debug"
    case beta = "Beta"
    case release = "Release"
}

extension Configuration: CustomStringConvertible {
    public var description: String { rawValue }
}
