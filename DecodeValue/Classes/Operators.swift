//
//  DecodeValue.Operator.swift
//  DecodeValue
//
//  Created by OutOfCoding on 2018. 11. 25...
//  Copyright © 2020년 outofcoding. All rights reserved.
//

postfix operator *
infix operator <~

// MARK: - JSONString

public postfix func *(original: JSONString?) -> String {
    return original.valueOrEmpty
}

public func <~(lhs: inout String, rhs: JSONString?) {
    lhs = rhs.valueOrEmpty
}

// MARK: - JSONInt

public postfix func *(original: JSONInt?) -> Int {
    return original.valueOrZero
}

public func <~(lhs: inout Int, rhs: JSONInt?) {
    lhs = rhs.valueOrZero
}

// MARK: - JSONDouble

public postfix func *(original: JSONDouble?) -> Double {
    return original.valueOrZero
}

public func <~(lhs: inout Double, rhs: JSONDouble?) {
    lhs = rhs.valueOrZero
}

// MARK: - JSONDictionary

public postfix func *<T>(original: JSONDictionary<T>?) -> [String: T] where T: Decodable {
    return original?.value ?? [:]
}

public func <~<T>(lhs: inout [String: T], rhs: JSONDictionary<T>?) {
    lhs = rhs?.value ?? [:]
}

// MARK: - JSONArray

public postfix func *<T>(original: JSONArray<T>?) -> [T] where T: Decodable {
    return original?.value ?? []
}

public func <~<T>(lhs: inout [T], rhs: JSONArray<T>?) {
    lhs = rhs?.value ?? []
}

// MARK: - JSONValue

public postfix func *<T>(original: JSONValue<T>?) -> T? {
    return original?.value
}

public func <~<T>(lhs: inout T?, rhs: JSONValue<T>?) {
    lhs = rhs?.value
}
