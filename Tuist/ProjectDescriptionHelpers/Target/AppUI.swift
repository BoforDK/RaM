//
//  AppUI.swift
//  ProjectDescriptionHelpers
//
//  Created by Alexander Grigorov on 10.11.2024.
//

import ProjectDescription

private let targetName = "AppUI"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).ui"

// MARK: - Target

public let appUI = Target.target(
    name: targetName,
    destinations: .iOS,
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: "\(targetName)/Sources/**",
    resources: ["\(targetName)/Resources/**"],
    entitlements: nil,
    dependencies: []
)
