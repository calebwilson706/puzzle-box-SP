//
//  File.swift
//  
//
//  Created by Caleb Wilson on 15/03/2021.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

extension String {
    func doesContainDoubleLetter() -> Bool {
        let chars = [Character](self)
        
        for index in 0 ..< (chars.count - 1) {
            if (chars[index] == chars[index + 1]){
                return true
            }
        }
        
        return false
    }
}
