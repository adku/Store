// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Store",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Store",
            targets: ["Store"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Store",
            dependencies: []),
        .testTarget(
            name: "StoreTests",
            dependencies: ["Store"]),
    ]
)
