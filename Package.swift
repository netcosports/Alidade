// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Alidade",
    platforms: [
      .iOS(.v9)
    ],
    products: [
			.library(name: "AlidadeCore", targets: ["AlidadeCore"]),
			.library(name: "AlidadeUIExtension", targets: ["AlidadeUIExtension"]),
			.library(name: "AlidadeUI", targets: ["AlidadeUI"]),
			.library(name: "AlidadeBoxed", targets: ["AlidadeBoxed"]),
			.library(name: "AlidadeAssociatable", targets: ["AlidadeAssociatable"]),
			.library(name: "AlidadeBezierExtractor", targets: ["AlidadeBezierExtractor"]),
			.library(name: "AlidadeCoreAnimation", targets: ["AlidadeCoreAnimation"]),
			.library(name: "AlidadeFlowable", targets: ["AlidadeFlowable"]),
			.library(name: "AlidadeFormatterPool", targets: ["AlidadeFormatterPool"]),
			.library(name: "AlidadeFunctionalAnimation", targets: ["AlidadeFunctionalAnimation"]),
			.library(name: "AlidadeVectors", targets: ["AlidadeVectors"]),
			.library(name: "AlidadeGeometry", targets: ["AlidadeGeometry"]),
			.library(name: "AlidadeString", targets: ["AlidadeString"]),
			.library(name: "AlidadeLogging", targets: ["AlidadeLogging"]),
      .library(name: "AlidadeDefault", targets: ["AlidadeDefault"])
    ],
    targets: [
			.target(name: "AlidadeCore", path: "./Alidade/Source/Core"),
			.target(name: "AlidadeUIExtension", dependencies: ["AlidadeCore"], path: "./Alidade/Source/UIExtension"),
			.target(name: "AlidadeUI", dependencies: ["AlidadeCore"], path: "./Alidade/Source/UI"),
			.target(name: "AlidadeBoxed", sources: ["./Alidade/Source/Other/Boxed.swift"]),
			.target(name: "AlidadeAssociatable", dependencies: ["AlidadeBoxed"], sources: ["./Alidade/Source/Other/Associatable.swift"]),
			.target(name: "AlidadeBezierExtractor", sources: ["./Alidade/Source/Other/BezierExtractor.swift"]),
			.target(name: "AlidadeCoreAnimation", path: "./Alidade/Source/CoreAnimation"),
			.target(name: "AlidadeFlowable", sources: ["./Alidade/Source/Other/Flowable.swift"]),
			.target(name: "AlidadeFormatterPool", sources: ["./Alidade/Source/Other/FormatterPool.swift"]),
			.target(name: "AlidadeDefault", dependencies: ["AlidadeCore", "AlidadeFormatterPool", "AlidadeUIExtension"]),
			.target(name: "AlidadeFunctionalAnimation", dependencies: ["AlidadeCore"], path: "./Alidade/Source/Other/FunctionalAnimation"),
			.target(name: "AlidadeVectors", dependencies: ["AlidadeCore"], path: "./Alidade/Source/Vectors"),
			.target(name: "AlidadeGeometry", dependencies: ["AlidadeCore", "AlidadeVectors"], path: "./Alidade/Source/Geometry"),
			.target(name: "AlidadeString", dependencies: ["AlidadeCore"], path: "./Alidade/Source/String"),
			.target(name: "AlidadeLogging", dependencies: ["AlidadeCore"], sources: ["./Alidade/Source/Other/Logging.swift"])
    ],
    swiftLanguageVersions: [.v5]
)
