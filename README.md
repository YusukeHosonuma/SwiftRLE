# Swift-RLE

Run-length encoding (RLE) library for Swift.

## Usage

```swift
// Encode
SwiftRLE.encode("ABBBCCD") // "1A3B2C1D"
SwiftRLE.encode("ABBBCCD", strategy: .normal)       // "1A3B2C1D"
SwiftRLE.encode("ABBBCCD", strategy: .omitOneDigit) // "A3B2CD"

// Decode
SwiftRLE.decode("1A3B2C1D") // "ABBBCCD"
SwiftRLE.decode("A3B2CD")   // "ABBBCCD"
```

## Install (Swift Package Manager)

```swift
.package(url: "https://github.com/YusukeHosonuma/SwiftRLE.git", from: "0.1.0")
```

## Author

Yusuke Hosonuma / tobi462@gmail.com

## License

SwiftRLE is available under the MIT license. See the LICENSE file for more info.
