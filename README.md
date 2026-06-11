![Jukebox: audio player in Swift](https://raw.githubusercontent.com/teodorpatras/Jukebox/master/assets/jukebox.png)

![Swift Package Manager](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg?style=flat)
![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)

Jukebox is an iOS audio player written in Swift.

# Contents
1. [Features](#features)
2. [Installation](#installation)
3. [Supported OS & SDK versions](#supported-versions)
4. [Usage](#usage)
5. [Handling remote events](#remote-events)
6. [Public interface](#public-interface)
7. [Delegation](#delegation)
8. [License](#license)
9. [Contact](#contact)

## <a name="features"> Features </a>

- [x] Support for streaming both remote and local audio files
- [x] Support for streaming live audio feeds
- [x] Functions to `play`, `pause`, `stop`, `replay`, `play next`, `play previous`, `control volume` and `seek` to a certain second.
- [x] Background mode integration with `MPNowPlayingInfoCenter`

<a name="installation"> Installation </a>
--------------

### Swift Package Manager

In Xcode:

1. Open your project.
2. Go to File > Add Package Dependencies.
3. Enter this repository URL.
4. Select the required version, branch, or commit.
5. Add the `Jukebox` package product to your app target.

Minimum supported iOS version: 15.6.

SwiftPM currently supports declaring iOS platform versions by major release in `Package.swift`, so this package declares `.iOS(.v15)` while the intended minimum runtime for this fork is iOS 15.6.

If this fork does not have a release tag yet, install it by selecting the desired branch or commit in Xcode's package dependency dialog.

## <a name="supported-versions"> Supported OS & SDK versions </a>

- iOS 15.6+
- Xcode 15 or newer recommended
- Swift Package Manager

## <a name="usage"> Usage </a>

### Prerequisites

* In order to support background mode, append the following to your `Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>
```

* If you want to stream from `http://` URLs, append the following to your `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
        <true/>
</dict>
```

### Getting started

1. Import Jukebox and create an instance:

```swift
import Jukebox

// configure jukebox
jukebox = Jukebox(delegate: self, items: [
    JukeboxItem(URL: URL(string: "http://www.noiseaddicts.com/samples_1w72b820/2514.mp3")!),
    JukeboxItem(URL: URL(string: "http://www.noiseaddicts.com/samples_1w72b820/2958.mp3")!)
])
```

2. Play and enjoy:

```swift
jukebox?.play()
```

## <a name="remote-events"> Handling remote events </a>

In order to handle remote events, you should do the following:

* First, call for receiving remote events:

```swift
UIApplication.shared.beginReceivingRemoteControlEvents()
```

* Secondly, override `remoteControlReceived(with:)`:

```swift
override func remoteControlReceived(with event: UIEvent?) {
    if event?.type == .remoteControl {
        switch event!.subtype {
        case .remoteControlPlay:
            jukebox.play()
        case .remoteControlPause:
            jukebox.pause()
        case .remoteControlNextTrack:
            jukebox.playNext()
        case .remoteControlPreviousTrack:
            jukebox.playPrevious()
        case .remoteControlTogglePlayPause:
            if jukebox.state == .playing {
               jukebox.pause()
            } else {
                jukebox.play()
            }
        default:
            break
        }
    }
}
```

## <a name="public-interface"> Public interface </a>

### Public methods

```swift
/**
 Starts item playback.
*/
public func play()

/**
 Plays the item indicated by the passed index.

 - parameter index: index of the item to be played
*/
public func play(atIndex index: Int)

/**
 Pauses the playback.
*/
public func pause()

/**
 Stops the playback.
*/
public func stop()

/**
 Starts playback from the beginning of the queue.
*/
public func replay()

/**
 Plays the next item in the queue.
*/
public func playNext()

/**
 Restarts the current item or plays the previous item in the queue.
*/
public func playPrevious()

/**
 Restarts the playback for the current item.
*/
public func replayCurrentItem()

/**
 Seeks to a certain second within the current AVPlayerItem and starts playing.

 - parameter second: the second to seek to
 - parameter shouldPlay: pass true if playback should be resumed after seeking
*/
public func seek(toSecond second: Int, shouldPlay: Bool = false)

/**
 Appends and optionally loads an item.

 - parameter item: the item to be appended to the play queue
 - parameter loadingAssets: pass true to load item's assets asynchronously
*/
public func append(item: JukeboxItem, loadingAssets: Bool)
```

### JukeboxItem initializer

```swift
/**
 Creates a new item.

 - parameter URL: local or remote URL of the audio file
 - parameter localTitle: an optional title for the file
*/
public required init(URL: Foundation.URL, localTitle: String? = nil)
```

## <a name="delegation"> Delegation </a>

Conform to `JukeboxDelegate` to observe playback, queue, and metadata updates:

```swift
public protocol JukeboxDelegate: AnyObject {
    func jukeboxStateDidChange(_ jukebox: Jukebox)
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox)
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem)
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem)
}
```

## <a name="license"> License </a>

Jukebox is available under the MIT license. See the LICENSE file for more info.

## <a name="contact"> Contact </a>

Original author: Teodor Patras
