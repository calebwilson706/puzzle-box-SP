//
//  File.swift
//  
//
//  Created by Caleb Wilson on 15/03/2021.
//

import Foundation

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    func containsDoubleLetter() -> Bool {
        let chars = [Character](self)
        
        for index in 0 ..< (chars.count - 1) {
            if (chars[index] == chars[index + 1]){
                return true
            }
        }
        
        return false
    }
}
