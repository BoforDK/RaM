// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            .upToNextMajor(from: "1.17.6")
        )
    ]
)
