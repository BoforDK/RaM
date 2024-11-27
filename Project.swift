import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "RaM",
    settings: .settings(
        base: [
            "IPHONEOS_DEPLOYMENT_TARGET": "18.0",
        ]
    ),
    targets: [
        app,
        appCore,
        appUI,
    ]
)

