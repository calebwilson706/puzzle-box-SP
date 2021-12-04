//
//  File.swift
//  
//
//  Created by Caleb Wilson on 04/12/2021.
//
import Foundation
@testable import PuzzleBox
import XCTest

final class LinesTests: XCTestCase {

    func testLinesReturnValue() throws {
        let input = """
1
2
3
"""
        let result = input.lines
        
        
        XCTAssertEqual(result, ["1", "2", "3"])
    }
    
    static var allTests = [
        ("Test Lines Returns The Lines Of A String", testLinesReturnValue),
    ]
}
