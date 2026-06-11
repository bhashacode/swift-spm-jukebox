# Release Notes

## SwiftPM-only migration

- Removed CocoaPods and Carthage distribution support from this fork.
- Added first-class Swift Package Manager support through a root `Package.swift` manifest.
- Moved library sources into the SwiftPM-native `Sources/Jukebox/` layout.
- Declared the SwiftPM platform as `.iOS(.v15)` because SwiftPM cannot express iOS 15.6 exactly in `Package.swift`.
- Intended minimum runtime for this fork: iOS 15.6.
