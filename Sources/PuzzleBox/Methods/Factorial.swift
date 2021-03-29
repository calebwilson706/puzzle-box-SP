//
//  File.swift
//  
//
//  Created by Caleb Wilson on 29/03/2021.
//

import Foundation

public func factorial(n : Int) -> Int {
    var answers = [
        1 : 1
    ]
    
    for x in 2...n {
        answers[x] = answers[x - 1]!*x
    }
    
    return answers[n]!
}
