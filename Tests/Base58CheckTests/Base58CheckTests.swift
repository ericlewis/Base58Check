import Foundation
import XCTest
@testable import Base58Check

final class Base58CheckTests: XCTestCase {
    private func sut() -> Base58Check {
        .init()
    }

    func testGivenData_WhenEncode_ThenEqualEncodedString() {
        let encodedString = "tz1Y3qqTg9HdrzZGbEjiCPmwuZ7fWVxpPtRw"
        XCTAssertEqual(sut().encode(data: testData), encodedString)
    }

    func testGivenEncodedString_WhenDecode_ThenEqualData() throws {
        let encodedString = "tz1Y3qqTg9HdrzZGbEjiCPmwuZ7fWVxpPtRw"
        XCTAssertEqual(try sut().decode(string: encodedString), testData)
    }

    func testGivenInvalidEncodedString_WhenDecode_ThenThrowInvalidDecodingError() {
        testDecodeString("0oO1lL", expectedError: .invalidDecoding)
    }

    func testGivenEncodedString_WithInvalidChecksum_WhenDecode_ThenThrowInvalidDecodingError() {
        testDecodeString("tz1Y3qqTg9HdrzZGbEjiCPmwuZ7fWVxpPtrW", expectedError: .invalidDecoding)
    }

    func testGivenEncodedString_WithLeadingOne_WhenDecode_ThenLeadingZero() throws {
        let encodedString = "1CdPoF9cvw3YEiuRCHxdsGpvb5tSUYBBo"
        XCTAssertEqual(try sut().decode(string: encodedString).first!, 0)
    }
}

// MARK: - Helpers
fileprivate extension Base58CheckTests {
    func testDecodeString(_ string: String, expectedError: Base58CheckError) {
        XCTAssertThrowsError(
            try sut().decode(string: string)
        ) { error in
            XCTAssertEqual(
                error as! Base58CheckError,
                expectedError
            )
        }
    }
}
