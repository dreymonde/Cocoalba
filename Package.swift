import PackageDescription

let package = Package(
    name: "Cocoalba",
    dependencies: [
        .Package(url: "https://github.com/dreymonde/Alba", majorVersion: 0, minor: 0),
    ]
)
