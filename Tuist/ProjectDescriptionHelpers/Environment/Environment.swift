//
//  Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by Alexander Grigorov on 29.09.2024.
//

import enum ProjectDescription.Environment

public enum Environment: String {
    public static var current: Self {
        .init(
            rawValue: ProjectDescription.Environment.environment
                .getString(default: Self.development.rawValue)
        ) ?? .development
    }

    case development = "Development"
    case production = "Production"

    public var appNameValue: String {
        switch self {
        case .development:
            return "DEV"
        case .production:
            return "PROD"
        }
    }
}

extension Environment: CustomStringConvertible {
    public var description: String { rawValue }
}
