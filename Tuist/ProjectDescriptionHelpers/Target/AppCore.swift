//
//  AppCore.swift
//  ProjectDescriptionHelpers
//
//  Created by Alexander Grigorov on 10.11.2024.
//

import ProjectDescription

private let targetName = "AppCore"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).core"

// MARK: - Target

public let appCore = Target.target(
    name: targetName,
    destinations: .iOS,
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: "\(targetName)/Sources/**",
    resources: [
        "\(targetName)/Resources/**",
    ],
    entitlements: nil,
    //todo
//    scripts: [
//        .swiftlint(),
//        .licensePlist()
//    ],
    dependencies: []
)
