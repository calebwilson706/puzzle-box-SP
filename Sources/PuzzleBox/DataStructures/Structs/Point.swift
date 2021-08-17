//
//  File.swift
//  
//
//  Created by Caleb Wilson on 15/03/2021.
//

import Foundation


public struct Point : Hashable {
    public var x : Int
    public var y : Int
    
    public init(x : Int, y : Int){
        self.x = x
        self.y = y
    }
    
    public func up() -> Point {
        return Point(x: x, y: y + 1)
    }
    
    public func down() -> Point {
        return Point(x: x, y: y - 1)
    }
    
    public func right() -> Point {
        return Point(x: x + 1, y: y)
    }
    
    public func left() -> Point {
        return Point(x: x - 1, y: y)
    }
    
    public func upLeft() -> Point {
        return Point(x: x - 1, y: y + 1)
    }
    
    public func downLeft() -> Point {
        return Point(x: x - 1, y: y - 1)
    }
    
    public func upRight() -> Point {
        return Point(x: x + 1, y: y + 1)
    }
    
    public func downRight() -> Point {
        return Point(x: x + 1, y: y - 1)
    }
    
    public func manhattanDistance(from: Point) -> Int {
        return abs(from.x - self.x) + abs(from.y - self.y)
    }
    
}
