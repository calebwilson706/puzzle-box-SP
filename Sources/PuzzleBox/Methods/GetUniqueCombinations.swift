//
//  File.swift
//  
//
//  Created by Caleb Wilson on 01/11/2021.
//

import Foundation

public extension Collection where Element: Equatable, Index == Int {
    
    func getUniqueCombinations() -> [(Element, Element)] {
        var result: [(Element, Element)] = []
        
        for firstIndex in (0 ..< count) {
            let first = self[firstIndex]
            
            for secondIndex in (firstIndex + 1 ..< count) {
                let second = self[secondIndex]
                
                result.append((
                    first, second
                ))
            }
        }
        
        return result
    }
}


