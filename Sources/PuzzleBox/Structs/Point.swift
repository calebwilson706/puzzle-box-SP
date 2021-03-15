//
//  File.swift
//  
//
//  Created by Caleb Wilson on 15/03/2021.
//

import Foundation


struct Point : Hashable {
    var x : Int
    var y : Int
    
    func up() -> Point {
        return Point(x: x, y: y + 1)
    }
    func down() -> Point {
        return Point(x: x, y: y - 1)
    }
    func right() -> Point {
        return Point(x: x + 1, y: y)
    }
    func left() -> Point {
        return Point(x: x - 1, y: y)
    }
    func upLeft() -> Point {
        return Point(x: x - 1, y: y + 1)
    }
    func downLeft() -> Point {
        return Point(x: x - 1, y: y - 1)
    }
    func upRight() -> Point {
        return Point(x: x + 1, y: y + 1)
    }
    func downRight() -> Point {
        return Point(x: x + 1, y: y - 1)
    }
}
