import XCTest
@testable import PuzzleBox

class UniqueCombinationsTests: XCTestCase {
    func testGetUniqueCombinations() {
        let values = ["a", "b", "c"]
        
        let result = values.getUniqueCombinations()
        let comparableResult = result.map { (first, second) in
            first + second
        }
        
        XCTAssertEqual(comparableResult, [
            "ab",
            "ac",
            "bc"
        ])
    }
    
    static let allTests = [
        ("Test get unique combinations", testGetUniqueCombinations)
    ]
}
