// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "swift-hf-api-mlx",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "MLXLMHFAPI", targets: ["MLXLMHFAPI"]),
        .library(name: "MLXEmbeddersHFAPI", targets: ["MLXEmbeddersHFAPI"]),
    ],
    dependencies: [
        // TODO: Switch from this pinned revision to a major-version dependency once mlx-swift-lm publishes a release that includes PR #118.
        .package(
            url: "https://github.com/ml-explore/mlx-swift-lm.git",
            revision: "67b146eba8cad6880d30dc3a883eb80cee29adca"
        ),
        .package(url: "https://github.com/DePasqualeOrg/swift-hf-api", from: "0.2.2"),
    ],
    targets: [
        .target(
            name: "MLXLMHFAPI",
            dependencies: [
                .product(name: "MLXLMCommon", package: "mlx-swift-lm"),
                .product(name: "HFAPI", package: "swift-hf-api"),
            ]
        ),
        .target(
            name: "MLXEmbeddersHFAPI",
            dependencies: [
                .product(name: "MLXEmbedders", package: "mlx-swift-lm"),
                "MLXLMHFAPI",
                .product(name: "HFAPI", package: "swift-hf-api"),
            ]
        ),
        .testTarget(
            name: "Benchmarks",
            dependencies: [
                "MLXLMHFAPI",
                .product(name: "BenchmarkHelpers", package: "mlx-swift-lm"),
            ]
        ),
    ]
)
