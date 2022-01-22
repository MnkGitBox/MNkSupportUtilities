# MNkSupportUtilities

[![Version](https://img.shields.io/cocoapods/v/MNkSupportUtilities.svg?style=flat)](https://cocoapods.org/pods/MNkSupportUtilities)
[![License](https://img.shields.io/cocoapods/l/MNkSupportUtilities.svg?style=flat)](https://cocoapods.org/pods/MNkSupportUtilities)
[![Platform](https://img.shields.io/cocoapods/p/MNkSupportUtilities.svg?style=flat)](https://cocoapods.org/pods/MNkSupportUtilities)

## What is MNkSupportUtilities?

MNkSupportUtilities contains different kinds of custom UI elements, subclasses, methods, and extensions to maintain a more organized, clear, and reusable codebase in your Swift project.

⚠️ From `v3.0.0` onward,  MNkAlertView, AppSymbol, UIKitChain and, the CustomLayout are moved to separate libraries and will not be a part of the MNkSupportUtilites.

⚠️ If you are willing to use MNkSupportUtilities with other separated libraries, you must use `v3.0.0` upwards. And the older versions below `v2.0.3` will not be support to use along with the separate libraries.

## Installation

### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```ruby
$ gem install cocoapods
```
To integrate MNkSupportUtilities into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'MNkSupportUtilities', '~> 2.0.3'
end
```
Then, run the following command:
```ruby
$ pod install
```

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 11+ is required to build MNkSupportUtilities using Swift Package Manager.

```Swift
dependencies: [
    .package(url: "https://github.com/MnkGitBox/MNkSupportUtilities.git", .upToNextMajor(from: "2.0.3"))
]
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate MNkSupportUtilities into your project manually.

---


## Components
- [MNkViewController](docs/MNkViewController_doc/doc.md)
- [MNkTableViewController](docs/MNkTableViewController_doc/doc.md)
- [MNKCollectionViewController](docs/MNkCollectionViewController_doc/doc.md)
- [MNkAlertView](docs/MNkAlertView_doc/doc.md) *(up to v2.0.3)*
- [AppSymbol](docs/AppSymbol_doc/doc.md) *(up to  v2.0.3)*
- [UIKitChain](docs/UIKitChain_doc/doc.md) *(up to v2.0.3)*
- [CustomLayout](docs/Custom_layout_doc/doc.md) *(up to v2.0.3)*

## Separate Libraries

📦  [MNkAlertView](https://github.com/MnkGitBox/MNkAlertView.git)

📦  [AppSymbol](https://github.com/MnkGitBox/AppSymbol.git)

📦  [UIKitChain](https://github.com/MnkGitBox/UIKitChain.git)

📦  [CustomLayout](https://github.com/MnkGitBox/CustomLayout.git)

## Credits
- Malith Nadeeshan ([malithnadeeshan](https://twitter.com/malithnadeeshan))

## License

MNkSupportUtilities is released under the MIT license. See LICENSE for details.
