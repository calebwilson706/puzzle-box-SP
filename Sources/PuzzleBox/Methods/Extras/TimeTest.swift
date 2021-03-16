//
//  File.swift
//  
//
//  Created by Caleb Wilson on 16/03/2021.
//

import Foundation

public func timeTest(call : () -> Void, num : Int, factor : Double = 1.0){
    let start = CFAbsoluteTimeGetCurrent()
    call()
    print("test \(num) : \((CFAbsoluteTimeGetCurrent() - start)*factor)")
}
