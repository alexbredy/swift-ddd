// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "swift-ddd",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/hmlongco/Resolver.git", "1.0.0" ..< "2.0.0"),
        .package(url: "https://github.com/vapor/postgres-kit.git", "2.0.0" ..< "3.0.0")
    ],
    targets: [
        .target(name: "Interface"),
        .target(
            name: "Service",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Resolver", package: "Resolver"),
                .product(name: "PostgresKit", package: "postgres-kit"),
                .target(name: "Interface")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "Service")]),
        .testTarget(name: "ServiceTests", dependencies: [
            .target(name: "Service"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
