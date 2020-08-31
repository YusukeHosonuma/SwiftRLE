// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRLE",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftRLE",
            targets: ["SwiftRLE"]),
    ],
    dependencies: [
        .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.12.0"),
    ],
    targets: [
        .target(
            name: "SwiftRLE",
            dependencies: []),
        .testTarget(
            name: "SwiftRLETests",
            dependencies: ["SwiftRLE", "SwiftCheck"]),
    ]
)
