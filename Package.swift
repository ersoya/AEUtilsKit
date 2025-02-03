// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AEUtilsKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "AEUtilsKit",
            targets: ["AEUtilsKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", from: "6.5.0")
    ],
    targets: [
        .target(
            name: "AEUtilsKit",
            dependencies: [
                "Kingfisher",
                .product(name: "IQKeyboardManagerSwift", package: "IQKeyboardManager")
            ]
        ),
        .testTarget(
            name: "AEUtilsKitTests",
            dependencies: ["AEUtilsKit"]
        )
    ]
)
