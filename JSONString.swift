//
//  JSONString.swift
//  DecodeValue
//
//  Created by OutOfCoding on 2018. 11. 25...
//  Copyright © 2020년 outofcoding. All rights reserved.
//

import Foundation

public enum JSONString : Decodable {
    case some(String)
    case none
    
    public init(from decoder: Decoder) throws {
        let value = try? DecodeValue(from: decoder)
        switch value {
        case .some(.string(let string)):
            self = .some(string)
        case .some(.int(let int)):
            self = .some(String(int))
        case .some(.double(let double)):
            self = .some(String(double))
        default:
            self = .none
        }
    }
}

public extension JSONString {
    
    var value: String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return ""
        }
    }
}

public extension Optional where Wrapped == JSONString {
    
    var valueOrEmpty: String {
        return (self?.value).or(JSONString.none.value)
    }
}
