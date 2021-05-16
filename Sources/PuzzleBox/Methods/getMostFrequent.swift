//
//  File.swift
//  
//
//  Created by Caleb Wilson on 16/05/2021.
//

import Foundation

public func mostFrequent(array: [Int]) -> (value: Int, count: Int)? {
    var counts = [Int: Int]()

    array.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }

    if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
        return (value, count)
    }

    return nil
}
