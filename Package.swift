// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "PrograManiacsSwiftUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PrograManiacsSwiftUI",
            type: .dynamic,
            targets: ["PrograManiacsSwiftUI"])
    ],
    targets: [
        .target(
            name: "PrograManiacsSwiftUI",
            path: "PrograManiacsSwiftUI"
        )
    ]
)
