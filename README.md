# DecodableValue
Decodable(Codable)의 parsing에 도움을 줍니다.

# Use Decodable
// json value is {name: "DH", age: 100}

```swift
struct People : Decodable {
  var name: String
  var age: Int
}
```
// People Data is name = DH, age = 100

// json value is {age: 100}. and run. go error case

# Use DecodeValue

```swift
struct People : Decodable {
  var name: JSONString
  var age: JSONInt
}
```
// People Data is name.value = "", age.value = ""
// parsing is not error. just value is default

# Use Operator

// * operator use. JSONString.value
```swift
let response = try JSONDecoder().decode(People.self, from: data) // data is some
print("name = \(*response.name)")
```

// <~ operator use. right to left
```swift
var name: String = ""

let response = try JSONDecoder().decode(People.self, from: data) // data is some
name <~ response.name
```
