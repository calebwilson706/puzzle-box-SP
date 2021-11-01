//
//  File.swift
//  
//
//  Created by Caleb Wilson on 01/06/2021.
//

import Foundation

public struct Point3D : Equatable, Hashable {
    public let x : Int
    public let y : Int
    public let z : Int
    
    public init(x : Int, y : Int, z : Int){
        self.x = x
        self.y = y
        self.z = z
    }
    
    public var neighbours : [Point3D] {
        var points = [Point3D]()
        
        x.adjacentAndSelf.forEach { x1 in
            y.adjacentAndSelf.forEach { y1 in
                z.adjacentAndSelf.forEach { z1 in
                    points.append(Point3D(x: x1, y: y1, z: z1))
                }
            }
        }
        
        points.removeAll { $0 == self }
        
        return points
    }
    
    public func moveX(offset: Int) -> Point3D {
        Point3D(x: x + offset, y: y, z: z)
    }
    
    public func moveY(offset: Int) -> Point3D {
        Point3D(x: x, y: y + offset, z: z)
    }
    
    public func moveZ(offset: Int) -> Point3D {
        Point3D(x: x, y: y, z: z + offset)
    }
}

public struct Point4D : Equatable, Hashable {
    public let x : Int
    public let y : Int
    public let z : Int
    public let w : Int
    
    public init(x : Int, y : Int, z : Int, w : Int){
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public var neighbours : [Point4D] {
        let points3D = Point3D(x: x, y: y, z: z).neighbours
        var results = [Point4D]()
        
        points3D.forEach { it in
            w.adjacentAndSelf.forEach { w1 in
                results.append(Point4D(x: it.x, y: it.y, z: it.z, w: w1))
            }
        }
        
        results.append(Point4D(x: x, y: y, z: z, w: w - 1))
        results.append(Point4D(x: x, y: y, z: z, w: w + 1))
        
        return results
    }
}

extension Int {
    var adjacentAndSelf : ClosedRange<Int> {
        self - 1 ... self + 1
    }
}
