// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-package",
  platforms: [.macOS(.v26)],
  dependencies: [
    .package(url: "https://github.com/lemo-nade-room/event-store-adapter-swift.git", from: "1.0.0"),
    .package(url: "https://github.com/lemo-nade-room/event-store-adapter-swift-support.git", from: "1.0.0"),
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
  ],
  targets: [
    .executableTarget(
      name: "App",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "EventStoreAdapter", package: "event-store-adapter-swift"),
        .product(name: "EventStoreAdapterDynamoDB", package: "event-store-adapter-swift"),
        .product(name: "EventStoreAdapterForMemory", package: "event-store-adapter-swift"),
        .product(name: "EventStoreAdapterSupport", package: "event-store-adapter-swift-support"),
      ],
      swiftSettings: swiftSettings,
    ),
    .testTarget(
      name: "AppTests",
      dependencies: [
        .product(name: "VaporTesting", package: "vapor"),
        .target(name: "App"),
      ],
      swiftSettings: swiftSettings,
    ),
  ],
  swiftLanguageModes: [.v6],
)
var swiftSettings: [SwiftSetting] {
  [
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("NonescapableTypes"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
  ]
}
