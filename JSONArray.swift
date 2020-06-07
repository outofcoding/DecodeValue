//
//  JSONArray.swift
//  DecodeValue
//
//  Created by OutOfCoding on 2018. 11. 25...
//  Copyright © 2020년 outofcoding. All rights reserved.
//

import Foundation

public enum JSONArray<T: Decodable> : Decodable {
    case some([T])
    case element(T?)
    case none
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = (try? container.decode([T].self)) {
            self = .some(value)
        } else if let element = (try? container.decode(T.self)) {
            self = .element(element)
        } else {
            self = .none
        }
    }
}

public extension JSONArray {
    
    var value: [T] {
        switch self {
        case .some(let value):
            return value
        case .element:
            return []
        case .none:
            return []
        }
    }
    
    var element: T? {
        switch self {
        case .some:
            return nil
        case .element(let element):
            return element
        case .none:
            return nil
        }
    }
}
