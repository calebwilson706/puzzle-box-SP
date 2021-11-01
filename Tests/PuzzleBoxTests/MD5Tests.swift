import XCTest
@testable import PuzzleBox

final class MD5Tests: XCTestCase {
    
    func testMD5ReturnsValue() throws {
        XCTAssertNotNil(MD5(string: "test"))
    }
    
    static var allTests = [
        ("Test md5 function returns a value", testMD5ReturnsValue),
    ]
}
