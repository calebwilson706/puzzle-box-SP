import XCTest
@testable import PuzzleBox

final class PuzzleBoxTests: XCTestCase {
    
    func treeTest() {
        let root = TreeNode<Int>(value: 50)
        root.addChild(newValue: 40)
        root.addChild(newValue: 60)
        root.addChild(newValue: 55)
        //root.addChild(newValue: 6)
        root.addChild(newValue: 65)
        root.addChild(newValue: 35)
        root.addChild(newValue: 45)
        root.addChild(newValue: 30)
        root.addChild(newValue: 37)
        print(root.asString)

        XCTAssertTrue(21 == 26)
    }
    
    static var allTests = [
        ("Tree Test", treeTest),
    ]
}
