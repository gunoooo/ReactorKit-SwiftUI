// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftUIReactorKit",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6),
    ],
    products: [
        .library(name: "SwiftUIReactorKit", targets: ["SwiftUIReactorKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0")),
    ],
    targets: [
        .target(
            name: "SwiftUIReactorKit",
            dependencies: [
                "ReactorKit",
            ]
        ),
        .testTarget(
            name: "SwiftUIReactorKitTests",
            dependencies: [
                "SwiftUIReactorKit",
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
