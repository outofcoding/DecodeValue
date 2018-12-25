MIT License

Copyright (c) 2018 OutOfCode

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

struct JSONValue<T: Decodable> : Decodable {
    var value: T?
    
    init(_ value: T) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = (try? container.decode(T.self)) {
            self.value = value
        }
    }
}

struct JSONString : Decodable {
    var value: String

    init(_ value: String) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let value = try? DecodeValue(from: decoder)
        switch value {
        case .some(.string(let string)):
            self.value = string
        case .some(.int(let int)):
            self.value = String(int)
        case .some(.double(let double)):
            self.value = String(double)
        default:
            self.value = ""
        }
    }
}

struct JSONInt : Decodable {
    var value: Int
    
    init(_ value: Int) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let value = try? DecodeValue(from: decoder)
        switch value {
        case .some(.int(let int)):
            self.value = int
        case .some(.string(let string)):
            self.value = Int(string) ?? 0
        case .some(.double(let double)):
            self.value = Int(double)
        case .some(.bool(let bool)):
            self.value = bool ? 1 : 0
        default:
            self = 0
        }
    }
}

struct JSONDictionary<T: Decodable> : Decodable {
    var value: [String: T]?
    var list: T?
    
    var isNil: Bool {
        return value == nil && list == nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = (try? container.decode([String: T].self)) {
            self.value = value
        } else if let list = (try? container.decode(T.self)) {
            self.list = list
        }
    }
}

struct JSONArray<T: Decodable> : Decodable {
    var value: [T]?
    var list: T?
    
    var isNil: Bool {
        return value == nil && list == nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = (try? container.decode([T].self)) {
            self.value = value
        } else if let list = (try? container.decode(T.self)) {
            self.list = list
        }
    }
}
