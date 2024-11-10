//
//  AppSetup.swift
//  ProjectDescriptionHelpers
//
//  Created by Alexander Grigorov on 29.09.2024.
//

import struct ProjectDescription.Configuration

public struct AppSetup {
    public static var current: Self {
        .init(environment: .current, configuration: .current)
    }

    public let environment: Environment
    public let configuration: Configuration
    public let moduleBundleIDPrefix = "com.requester"
    
    //todo: user real bundleID
    public var bundleID: String {
        switch (configuration, environment) {
        case (.debug, _):
            "com.requester.debug"
        case (.beta, .development):
            "com.requester.dev"
        case (.beta, .production):
            fatalError("Config: Beta, Environment: Production bundleID not configured")
        case (.release, .production):
            "com.requester.prod"
        case (.release, .development):
            fatalError("Config: Release, Environment: Production bundleID not configured")
        }
    }
    
    public var appNameValue: String {
        if configuration == .release, environment == .production {
            return ""
        }

        return environment.appNameValue
    }
    
    public var projectConfigurations: [ProjectDescription.Configuration] {
        switch configuration {
        case .debug:
            return [.debug(name: "Debug")]
        case .beta, .release:
            return [.release(name: "Release")]
        }
    }

    //todo: add teamID
    public var teamID: String {
        "YUZLMRGGBB"
    }

    public var codeSignStyle: String {
        switch configuration {
        case .debug:
            return "Automatic"
        case .beta, .release:
            return "Manual"
        }
    }
}

extension AppSetup: CustomStringConvertible {
    public var description: String { "\(configuration)/\(environment)" }
}

