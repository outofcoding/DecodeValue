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

enum DecodeValue : Decodable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: DecodeValue])
    case array([DecodeValue])
    case none
    
    init(from decoder: Decoder) throws {
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
