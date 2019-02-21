// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RambaMaker",
    dependencies: [
      .package(url: "https://github.com/tuist/xcodeproj.git", .upToNextMajor(from: "6.5.0")),
      .package(url: "https://github.com/marcoconti83/Corazza.git", .branch("master")),
      .package(url: "https://github.com/stencilproject/Stencil.git", .upToNextMajor(from: "0.13.1")),
      .package(url: "https://github.com/kylef/Commander.git", .upToNextMajor(from: "0.8.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RambaMaker",
            dependencies: ["xcodeproj", "Corazza", "Stencil", "Commander"]),
        .testTarget(
            name: "RambaMakerTests",
            dependencies: ["RambaMaker"]),
    ]
)
