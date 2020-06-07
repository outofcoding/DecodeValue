//
//  DecodeValue.swift
//  DecodeValue
//
//  Created by OutOfCoding on 2018. 11. 25...
//  Copyright © 2020년 outofcoding. All rights reserved.
//

import Optional_Extension

public enum DecodeValue : Decodable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: DecodeValue])
    case array([DecodeValue])
    case none
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = (try? container.decode(String.self)).map(DecodeValue.string)
            .or((try? container.decode(Int.self)).map(DecodeValue.int))
            .or((try? container.decode(Double.self)).map(DecodeValue.double))
            .or((try? container.decode(Bool.self)).map(DecodeValue.bool))
            .or((try? container.decode([String: DecodeValue].self)).map(DecodeValue.object))
            .or((try? container.decode([DecodeValue].self)).map(DecodeValue.array))
        
        self = value ?? DecodeValue.none
    }
}
