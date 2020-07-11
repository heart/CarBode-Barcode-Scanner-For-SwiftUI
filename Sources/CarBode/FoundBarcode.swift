//
//  File.swift
//  
//
//  Created by Darko Dujmovic on 10/07/2020.
//

import Foundation

public struct FoundBarcode{
    public let code:String
    public let type:String

    init(code: String, type: String) {
        self.code = code
        self.type = type
    }
}
