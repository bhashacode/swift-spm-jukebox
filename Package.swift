// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Jukebox",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Jukebox",
            targets: ["Jukebox"]
        )
    ],
    targets: [
        .target(
            name: "Jukebox",
            path: "Sources/Jukebox",
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("MediaPlayer"),
                .linkedFramework("UIKit")
            ]
        ),
        .testTarget(
            name: "JukeboxTests",
            dependencies: ["Jukebox"],
            path: "Tests/JukeboxTests"
        )
    ]
)
