## notes

### Struct

- No inheritance
- Value types
- Free initializer where all properties can be passed

### Value Types & Reference Types

https://medium.com/commencis/stop-using-structs-e1be9a86376f

- Value types:
  - `Collections`: `Array`, `String`, `Dictionary`, `Set` are all `Struct`s
  - `Enum`, `Tuple`, `Primitives`
- Reference types:
  - `Class`, `Anything coming from NSObject`, `Function`, `Closure`

### lazy properties

- only init when get accessed (so can access to other properties)
- cannot have `Property Observer` (`didSet`)

### Syntax of Closure

- https://docs.swift.org/swift-book/LanguageGuide/Closures.html

### Computed Property

```swift
    // if only has getter, can just return, no need the get key word
    var someComputedProperty: Int? {
      return someFunctionThatReturnInt()
    }
    // variable name, which is newValue by defaule can be omitted
    var someComputedProperty: Int? {
      // ...
      set {
        doSomethingWithNewValue(newValue)
      }
    }
```
