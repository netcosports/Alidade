// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Alidade",
    platforms: [
      .iOS(.v10)
    ],
    products: [
			.library(name: "Alidade", targets: ["Alidade"]),
    ],
    dependencies: [
      .package(
        url: "https://github.com/Quick/Nimble.git", .branch("main")
      )
    ],
    targets: [
      .target(
        name: "Alidade",
        path:"./Alidade/Source",
        linkerSettings: [
          .linkedFramework("UIKit", .when(platforms: [.iOS])),
        ]
      )
    ],
    swiftLanguageVersions: [.v5]
)
