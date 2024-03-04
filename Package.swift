// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "swift-preview-controller",
    products: [
        .library(name: "PreviewController", targets: ["PreviewController"]),
    ],
    targets: [
        .target(name: "PreviewController", swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]),
    ]
)
