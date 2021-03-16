//
//  File.swift
//  
//
//  Created by Caleb Wilson on 16/03/2021.
//

import Foundation


public func sumValuesUsingMethod<T>(in list : [T], using method : (T) -> Int) -> Int {
    return list.reduce(0, { acc, next in
        acc + method(next)
    })
}
