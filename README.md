# Swift-tutorials

## Data Types

#### Int

```swift
var number: Int
var number: Int = 10
var marks = 10
```

#### Float

```swift
var decimalNumber: Float
var decimalNumber: Float = 10.50
```

#### Double

```swift
var decimalNumber: Double
var decimalNumber: Double = 10.50
```

#### String

```swift
var productName: String
var productName: String = "Sim Kosal"
```

#### Bool

```swift
var liked: Bool
var liked: Bool = false
var liked: Bool = true
```

#### Charater

```swift
var letter: Character = "Sim Kosal"
var emoji: Character = "❤️❤️"
var letterEmoji = letter + emoji
```

## Operators

#### Addition 

```swift
var num1 = 10
var num2 = 20
var total = numer1 + num2
```

#### Subtraction 

```swift
var num1 = 50
var num2 = 20
var total = numer1 - num2
```

#### Multiplication

```swift
var num1 = 50
var num2 = 20
var total = numer1 * num2
```

#### Division

```swift
var num1 = 50
var num2 = 20
var total = numer1 / num2
```

#### Modulus

```swift
var num1 = 50
var num2 = 20
var total = numer1 % num2
```

## Prints && Comments

#### Printing a String 


```swift
print("Sim Kosal")
```

#### Printing a variable

```swift
var name: String = "Sim Kosal"
print(name)
```
#### Comments

## Condition Statements

#### If statement

```swift
var num: Int = 7
if num = 7 {
  print("You are right!")
}
```

#### If else statement

```swift
var num: Int = 7
if num = 7 {
  print("You are right!")
} else {
  print("You are wrong!")
}
```

#### If else continue

```swift
var num: Int = 7
if num = 7 {
  print("You are right!")
} else if num = 10 {
  print("You are wrong!")
} else {
  print("You are wrong!")
}
```

## Switch

```swift
var month: String = "jan"
switch month {
  case "jan":
      print("I am January")
  case "feb":
      print("I am February")
  case "mar":
      print("I am March")
  default:
      print("To the moon!")
}
```

## Loops

#### For in loop

```swift
for i in 1...10 {
  print(i)
}
for i in (1...10).reversed() {
  print(i)
}
```

#### While loop

```swift
var i = 0
while i< 10 {
  print(i)
  i += 1
}
```

#### repeat while loop

```swift
var number = 1
repeat {
    print(number)
    number += 1
} while number <= 20
```

### Arrays

### Declare array

```swift
var objs = [String]()
objs.append("Sim")
objs.append("Kosal")
print(objs)
print(objs.count) // length of arrays
print(objs[0]) // print value index 0
objs.remove(at:0) // removed value index0
objs.removeAll() // removed all data array

for ob in objs {
  print(ob) // print all the value 
}
-------------------
var numbers: [int] = [1,2,3,4,5]
var employee: [String] = ["Ronaldo","Messi","Neymar"]
```

#### Inserting Data
#### Retrieving Data


## Dictionaries

#### Create Dictionary && Initializing a Dictionary

```swift
// Declear dictionary
var myDictionary = [String:String]

// Assingning data into a dictionary
myDictionary["key1"] = "Iphone 12"
myDictionary["key2"] = "Iphone 13"

// Retrieving a value as optionl String
let myObj = myDictionary["key1"]
let myObj = myDictionary["key2"]

//Replace
myDictionary["key1"] = "Iphone 12"

// Remove
myDictionary["key1"] = nil
myDictionary["key2"] = nil

// Loop through the items of the dictionary
for (key,value) in myDictionary {
  print(key)
}

```




