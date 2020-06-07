//
//  JSONInt.swift
//  DecodeValue
//
//  Created by OutOfCoding on 2018. 11. 25...
//  Copyright © 2020년 outofcoding. All rights reserved.
//

import Foundation

public enum JSONInt : Decodable {
    case some(Int)
    case none

    public init(from decoder: Decoder) throws {
        let value = try? DecodeValue(from: decoder)
        switch value {
        case .some(.int(let int)):
            self = .some(int)
        case .some(.string(let string)):
            self = .some(Int(string) ?? 0)
        case .some(.double(let double)):
            self = .some(Int(double))
        case .some(.bool(let bool)):
            self = .some(bool ? 1 : 0)
        default:
            self = .none
        }
    }
}

public extension JSONInt {
    
    var value: Int {
        switch self {
        case .some(let value):
            return value
        case .none:
            return 0
        }
    }
}

public extension Optional where Wrapped == JSONInt {
    
    var valueOrZero: Int {
        return (self?.value).or(JSONInt.none.value)
    }
}
