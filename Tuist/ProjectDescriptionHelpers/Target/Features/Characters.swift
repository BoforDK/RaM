//
//  Characters.swift
//  Manifests
//
//  Created by Alexander Grigorov on 02.01.2025.
//

import ProjectDescription

private let targetName = "Characters"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).\(targetName)"
private let sources: [SourceFileGlob] = [
    "Features/\(targetName)/Sources/**",
    Configuration.current == .debug ? "Features/\(targetName)/Testing/**" : nil,
].compactMap { $0 }

public let characters: Target = .target(
    name: targetName,
    destinations: [.iPhone, .iPad, .macCatalyst],
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: .sourceFilesList(globs: sources),
    dependencies: [
        .target(appCore),
        .target(appUI),
    ]
)

public let charactersTests: Target = .target(
    name: "\(targetName)Tests",
    destinations: [.iPhone, .iPad, .macCatalyst],
    product: .unitTests,
    bundleId: "\(bundleID).tests",
    infoPlist: .default,
    sources: ["Features/\(targetName)/Tests/**"],
    resources: [],
    dependencies: [
        .target(name: targetName),
        .external(name: "SnapshotTesting"),
    ]
)

