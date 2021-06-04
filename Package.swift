// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Alidade",
    platforms: [
      .iOS(.v10)
    ],
    products: [
			.library(name: "Alidade", targets: ["Alidade"]),
			.library(name: "AlidadeCoreAnimation", targets: ["AlidadeCoreAnimation"]),
      .library(name: "AlidadeGeometry", targets: ["AlidadeGeometry"]),
      .library(name: "AlidadeVectors", targets: ["AlidadeVectors"]),
      .library(name: "AlidadeFunctionalAnimation", targets: ["AlidadeFunctionalAnimation"])
    ],
    dependencies: [
      .package(
        url: "https://github.com/Quick/Nimble.git", .branch("main")
      )
    ],
    targets: [
      .target(
        name: "Alidade",
        path:"./Alidade/Source/Root",
        linkerSettings: [
          .linkedFramework("UIKit", .when(platforms: [.iOS])),
        ]
      ),
      .testTarget(
        name: "AlidadeTests",
        dependencies: [
          "Nimble",
          "Alidade",
          "AlidadeCoreAnimation",
          "AlidadeGeometry",
          "AlidadeVectors",
          "AlidadeFunctionalAnimation"
        ]
      ),
      .target(
        name: "AlidadeGeometry",
        dependencies: ["Alidade"],
        path: "./Alidade/Source/Geometry"
      ),
      .target(
        name: "AlidadeVectors",
        dependencies: ["Alidade"],
        path: "./Alidade/Source/Vectors"
      ),
			.target(
        name: "AlidadeCoreAnimation",
        dependencies: ["Alidade"],
        path: "./Alidade/Source/CoreAnimation"
      ),
      .target(
        name: "AlidadeFunctionalAnimation",
        dependencies: ["Alidade"],
        path: "./Alidade/Source/FunctionalAnimation"
      )
    ],
    swiftLanguageVersions: [.v5]
)
