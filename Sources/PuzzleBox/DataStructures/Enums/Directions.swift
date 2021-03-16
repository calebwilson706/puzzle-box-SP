//
//  Directions.swift
//  
//
//  Created by Caleb Wilson on 16/03/2021.
//

import Foundation

public enum Directions {
    case NORTH, EAST, SOUTH, WEST
    
    func turnRight() -> Directions {
        switch self {
        case .NORTH:
            return .EAST
        case .EAST:
            return .SOUTH
        case .SOUTH:
            return .WEST
        case .WEST:
            return .NORTH
        }
    }
    
    func turnLeft() -> Directions {
        switch self {
        case .NORTH:
            return .WEST
        case .EAST:
            return .NORTH
        case .SOUTH:
            return .EAST
        case .WEST:
            return .SOUTH
        }
    }
}
