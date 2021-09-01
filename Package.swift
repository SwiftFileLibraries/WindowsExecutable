// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "WindowsExecutable",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "WindowsExecutable", targets: ["WindowsExecutable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftFileLibraries/BinaryCodable.git", from: "2.1.0"),
    ],
    targets: [
        .target(name: "WindowsExecutable", dependencies: [
            "BinaryCodable"
        ]),
        .testTarget(name: "WindowsExecutableTests", dependencies: ["WindowsExecutable"]),
    ]
)
