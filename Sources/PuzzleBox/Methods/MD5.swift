//
//  File.swift
//  
//
//  Created by Caleb Wilson on 22/03/2021.
//

import Foundation
import CryptoKit

public func md5(of string : String) -> String {
    let computed = Insecure.MD5.hash(data: string.data(using: .utf8)!)
    return computed.map { String(format: "%02hhx", $0) }.joined()
}
