import XCTest
import SwiftCheck
@testable import SwiftRLE

final class SwiftRLETests: XCTestCase {
    func testEncode() {
        // Valid
        XCTAssertEqual(SwiftRLE.encode("ABBBCCD", strategy: .normal),       "1A3B2C1D")
        XCTAssertEqual(SwiftRLE.encode("ABBBCCD", strategy: .omitOneDigit), "A3B2CD")
        XCTAssertEqual(SwiftRLE.encode("", strategy: .normal), "")

        // Invalid
        XCTAssertNil(SwiftRLE.encode("1", strategy: .normal), "")
        XCTAssertNil(SwiftRLE.encode("A1", strategy: .normal), "")
    }

    func testDecode() {
        // Valid
        XCTAssertEqual(SwiftRLE.decode("1A3B2C1D"), "ABBBCCD")
        XCTAssertEqual(SwiftRLE.decode("A3B2CD"),   "ABBBCCD")
        XCTAssertEqual(SwiftRLE.decode("A3BC10D"),  "ABBBCDDDDDDDDDD")
        XCTAssertEqual(SwiftRLE.decode(""), "")

        // Invalid
        XCTAssertNil(SwiftRLE.decode("1"))
        XCTAssertNil(SwiftRLE.decode("12"))
        XCTAssertNil(SwiftRLE.decode("1A3B2C1D1"), "ABBBCCD")
    }
    
    func testProperty() {
        property("Encoding and decoding must be symmetrical.") <- forAll { (s: RLEEncodableString) in
            return
                (SwiftRLE.decode(SwiftRLE.encode(s.string, strategy: .normal)!) == s.string) <?> ".normal"
                ^&&^
                (SwiftRLE.decode(SwiftRLE.encode(s.string, strategy: .omitOneDigit)!) == s.string) <?> ".omitOneDigit"

        }
    }
}

final class SequenceTests: XCTestCase {
    func testGroupBy() {
        XCTAssertEqual([Int]().group(by: { $0 == $1 }), [])
        XCTAssertEqual([1, 2, 2, 2, 3, 3, 4].group(by: { $0 == $1 }),
                       [[1], [2, 2, 2], [3, 3], [4]])
    }
}

// MARK: Helper

private struct RLEEncodableString: Arbitrary {
    let string: String

    static var arbitrary: Gen<RLEEncodableString> {
        return Gen<RLEEncodableString>.compose { c in
            let count: UInt = c.generate()
            let characters: [Character] = (0..<count).map { _ in
                c.generate(using: Gen<Character>.fromElements(in: "A"..."D"))
            }
            return RLEEncodableString(string: String(characters))
        }
    }
}
