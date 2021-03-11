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
//			.library(name: "AlidadeFunctionalAnimation", targets: ["AlidadeFunctionalAnimation"]),
//			.library(name: "AlidadeVectors", targets: ["AlidadeVectors"]),
//			.library(name: "AlidadeGeometry", targets: ["AlidadeGeometry"]),
			.library(name: "AlidadeString", targets: ["AlidadeString"]),
			.library(name: "AlidadeLogging", targets: ["AlidadeLogging"]),
    ],
    targets: [
			.target(name: "AlidadeCore", path: "./Alidade/Source/Core"),
			.target(name: "AlidadeUIExtension", dependencies: ["AlidadeCore"], path: "./Alidade/Source/UIExtension"),
			.target(name: "AlidadeUI", dependencies: ["AlidadeCore"], path: "./Alidade/Source/UI"),
			.target(name: "AlidadeBoxed", path: "./Alidade/Source/Other", sources: ["Boxed.swift"]),
			.target(name: "AlidadeAssociatable",
							dependencies: ["AlidadeBoxed"],
							path: "./Alidade/Source/Other",
							sources: ["Associatable.swift"]),
			.target(name: "AlidadeBezierExtractor",
							path: "./Alidade/Source/Other",
							sources: ["BezierExtractor.swift"]),
			.target(name: "AlidadeCoreAnimation", path: "./Alidade/Source/CoreAnimation"),
			.target(name: "AlidadeFlowable", path: "./Alidade/Source/Other", sources: ["Flowable.swift"]),
			.target(name: "AlidadeFormatterPool", path: "./Alidade/Source/Other", sources: ["FormatterPool.swift"]),
//			.target(name: "AlidadeFunctionalAnimation",
//							dependencies: ["AlidadeCore"],
//							path: "./Alidade/Source/Other/FunctionalAnimation"),
//			.target(name: "AlidadeVectors", dependencies: ["AlidadeCore"], path: "./Alidade/Source/Vectors"),
//			.target(name: "AlidadeGeometry", dependencies: ["AlidadeCore", "AlidadeVectors"], path: "./Alidade/Source/Geometry"),
			.target(name: "AlidadeString", dependencies: ["AlidadeCore"], path: "./Alidade/Source/String"),
			.target(name: "AlidadeLogging",
							dependencies: ["AlidadeCore"],
							path: "./Alidade/Source/Other",
							sources: ["Logging.swift"])
    ],
    swiftLanguageVersions: [.v5]
)
