//
//  App.swift
//  ProjectDescriptionHelpers
//
//  Created by Alexander Grigorov on 29.09.2024.
//

import ProjectDescription

private let targetName = "App"
private let bundleID = AppSetup.current.bundleID
private let appName: String = {
    if Environment.current == .production, Configuration.current == .release {
        return targetName
    }

    return [
        targetName,
        AppSetup.current.appNameValue
    ].joined(separator: " ")
}()

public let app: Target = .target(
    name: targetName,
    destinations: [.iPhone, .iPad, .macCatalyst],
    product: .app,
    bundleId: bundleID,
    infoPlist: .extendingDefault(
        with: [
            "CFBundleDisplayName": .string(appName),
            "UILaunchScreen": .dictionary([:]),
        ]
    ),
    sources: ["\(targetName)/Sources/**"],
    resources: ["\(targetName)/Resources/**"],
    entitlements: "App/App.entitlements",
    dependencies: [
        .external(name: "Swinject")
    ],
    settings: .settings(
        base: [
            //todo
            "DEVELOPMENT_TEAM": .string(AppSetup.current.teamID),
//            "CODE_SIGN_IDENTITY": .string("Apple development"),
//            "PROVISIONING_PROFILE_SPECIFIER": .string(""),
        ],
        configurations: AppSetup.current.projectConfigurations
    )
)

public let appTests: Target = .target(
    name: "\(targetName)Tests",
    destinations: [.iPhone, .iPad, .macCatalyst],
    product: .unitTests,
    bundleId: "\(bundleID).tests",
    infoPlist: .default,
    sources: ["\(targetName)/Tests/**"],
    resources: [],
    dependencies: [
        .target(name: targetName),
    ]
)
