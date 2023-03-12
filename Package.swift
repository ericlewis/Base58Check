// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Base58Check",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Base58Check",
            targets: ["Base58Check"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/anquii/Base58.git",
            .exact("1.0.1")
        )
    ],
    targets: [
        .target(
            name: "Base58Check",
            dependencies: ["Base58"]
        ),
        .testTarget(
            name: "Base58CheckTests",
            dependencies: ["Base58Check"]
        )
    ]
)
