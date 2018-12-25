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
