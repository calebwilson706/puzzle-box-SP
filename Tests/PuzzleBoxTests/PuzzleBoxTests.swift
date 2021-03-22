import XCTest
@testable import PuzzleBox

final class PuzzleBoxTests: XCTestCase {
    
    func md5Test() throws {
        XCTAssertNotNil(MD5(string: "test"))
    }
    
    static var allTests = [
        ("Test", md5Test),
    ]
}
