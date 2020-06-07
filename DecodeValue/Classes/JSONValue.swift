//
//  JSONValue.swift
//  DecodeValue
//
//  Created by OutOfCoding on 2018. 11. 25...
//  Copyright © 2020년 outofcoding. All rights reserved.
//

public enum JSONValue<T: Decodable> : Decodable {
    case some(T)
    case none
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = (try? container.decode(T.self)) {
            self = .some(value)
        } else {
            self = .none
        }
    }
}

public extension JSONValue {
    
    var value: T? {
        switch self {
        case .some(let value):
            return value
        case .none:
            return nil
        }
    }
}
