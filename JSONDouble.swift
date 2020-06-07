//
//  JSONDouble.swift
//  DecodeValue
//
//  Created by OutOfCoding on 2018. 11. 25...
//  Copyright © 2020년 outofcoding. All rights reserved.
//

import Foundation

public enum JSONDouble : Decodable {
    case some(Double)
    case none

    public init(from decoder: Decoder) throws {
        let value = try? DecodeValue(from: decoder)
        switch value {
        case .some(.int(let int)):
            self = .some(Double(int))
        case .some(.string(let string)):
            self = .some(Double(string) ?? 0.0)
        case .some(.double(let double)):
            self = .some(double)
        case .some(.bool(let bool)):
            self = .some(bool ? 1 : 0)
        default:
            self = .none
        }
    }
}

public extension JSONDouble {
    
    var value: Double {
        switch self {
        case .some(let value):
            return value
        case .none:
            return 0.0
        }
    }
}

public extension Optional where Wrapped == JSONDouble {
    
    var valueOrZero: Double {
        return (self?.value).or(JSONDouble.none.value)
    }
}
