# DecodableValue
Decodable(Codable)의 parsing에 도움을 줍니다.

# Use Decodable
```swift
struct People : Decodable {
  var name: String
  var age: Int
}
```
json value is {name: "DH", age: 100}<br/>
People Data is name = DH, age = 100

json value is {age: 100}.<br/>
parsing error.

# Use DecodeValue

```swift
struct People : Decodable {
  var name: JSONString
  var age: JSONInt
}
```
json value is {age: 100}.<br/>
People Data is name.value = "", age.value = 100<br/>
parsing is not error. just value is default

# Use JSONValue

```swift
struct People : Decodable {
  var name: JSONValue<String>
  var age: JSONValue<Int>
}
```
People Data is Generic Data.<br/>
people.name.value is String value

# Use Operator

```* operator. same JSONString.value```
```swift
let response = try JSONDecoder().decode(People.self, from: data) // data is some
print("name = \(*response.name)")
```

```<~ operator. same right to left```
```swift
var name: String = ""

let response = try JSONDecoder().decode(People.self, from: data) // data is some
name <~ response.name
```
