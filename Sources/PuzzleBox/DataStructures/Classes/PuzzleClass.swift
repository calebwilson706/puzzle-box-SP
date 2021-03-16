//
//  File.swift
//  
//
//  Created by Caleb Wilson on 16/03/2021.
//

import Foundation

public protocol PuzzleClassProtocol {
    public func part1() -> Void
    public func part2() -> Void 
}

public class PuzzleClass {
    public var inputStringUnparsed : String?
    
    public init(filePath : String?) {
        if let path = filePath {
            do {
                self.inputStringUnparsed = try String(contentsOfFile: path)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


