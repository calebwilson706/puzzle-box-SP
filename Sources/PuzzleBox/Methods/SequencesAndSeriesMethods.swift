//
//  SequenceAndSeriesMethods.swift
//  
//
//  Created by Caleb Wilson on 16/03/2021.
//

import Foundation


public func sumOfNumbers(from start : Int, to end : Int, withStep step : Int) -> Int {
    let count = Double((end - start)/step + 1)
    let totalAsDouble = Double(count/2.0) * Double(2*start + (Int(count - 1.0))*step)
    
    return Int(totalAsDouble)
}

