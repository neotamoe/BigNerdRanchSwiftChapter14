//: Playground - noun: a place where people can play

import UIKit

// enumerations (or enums) allow you to create instances that are one of a defined list of cases
// written below--> TextAlignment is now usable as a Type, just like Int or String or other Types...
// enums begin with capital letters by convention and are camelCased
// side note: variables, functions and enum cases begin with lowercase letter and are camelCased if needed

//enum TextAlignment {
//    case left
//    case right
//    case center
//    case justify
//}

//var alignment: TextAlignment = TextAlignment.left

// rewritten using type inference
//var alignment = TextAlignment.left

// inferring the enum type
//alignment = .right

// type inference when comparing values
if alignment == .right {
    print("We should right-align the text.")
}

// however, switch statements are usually used to handle enum values
// do not need a default case if you include all the enum values
//switch alignment {
//case .left:
//    print("left aligned")
//case .right:
//    print("right aligned")
//case .center:
//    print("center aligned")
//}

// but you could do it this way too...though it is not recommended when switching on enum types because using a default is not as "future proof" such as now when we add case justify to the enum on line 14 and make new var on line 42--it prints the wrong value using the default case
var alignment = TextAlignment.justify
switch alignment {
case .left:
    print("left aligned")
case .right:
    print("right aligned")
case .center:
    print("center aligned")
case .justify:
    print("justified")
}

// now the compile-time error appears that the switch is not exhaustive
//so we go back and add the case on line 50

// RAW VALUE ENUMERATIONS
//swift enums don't have an underlying integer type
// but you can use that same behavior (as in C or C++) by using a raw value
//enum TextAlignment: Int {
//    case left
//    case right
//    case center
//    case justify
//}
// written this way, each case is now assigned a raw value starting with 0 for first case
//print ("left has raw value \(TextAlignment.left.rawValue)")
// 0
//print ("right has raw value \(TextAlignment.right.rawValue)")
// 1
//print ("center has raw value \(TextAlignment.center.rawValue)")
// 2
//print ("justify has raw value \(TextAlignment.justify.rawValue)")
// 3

// you can specify raw values too
enum TextAlignment: Int {
    case left    = 20
    case right   = 30
    case center  = 40
    case justify = 50
}

// converting raw values to enum types
let myRawValue = 20

// try to convert the raw value into a TextAlignment
if let myAlignment = TextAlignment(rawValue: myRawValue){
    // conversion succeeded
    print("successfully converted \(myRawValue) into a TextAlignment")
} else {
    //conversion failed
    print("\(myRawValue) has no corresponding TextAlignment case")
}

// creating an enum with Strings
//enum ProgrammingLanguage: String {
//    case swift      = "swift"
//    case objectiveC = "objective-c"
//    case c          = "c"
//    case cpp        = "c++"
//    case java       = "java"
//}
//
//let myFavoriteLanguage = ProgrammingLanguage.swift
//print("my favorite programming language is \(myFavoriteLanguage.rawValue)")

// you don't have to specify the raw values...if you don't specify a raw value, swift will use the name of the case itself.
enum ProgrammingLanguage: String {
    case swift
    case objectiveC = "objective-c"
    case c
    case cpp        = "c++"
    case java
}

let myFavoriteLanguage = ProgrammingLanguage.swift
print("my favorite programming language is \(myFavoriteLanguage.rawValue)")
// see?!  it still works

// METHODS
// the function in enum Lightbulb is a method on Lightbulb
// the function takes a single parameter (ambient) and an implicit argument named "self" of type Lightbulb
enum Lightbulb {
    case on
    case off
    
    func surfaceTemperature (forAmbientTemperature ambient: Double) -> Double {
        switch self {
        case .on:
            return ambient + 150.0
        case .off:
            return ambient
        }
    }
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var bulb = Lightbulb.on
let ambientTemperature = 77.0

var bulbTemperature = bulb.surfaceTemperature(forAmbientTemperature: ambientTemperature)
print("the bulb's temperature is \(bulbTemperature)")

// now add a toggle to the method above
// without mutating on line 135, you will get a compiler error saying you can't assign to self inside a method.  enumeration is a value type and methods on value types aren't allowed to make changes to self.
bulb.toggle()
bulbTemperature = bulb.surfaceTemperature(forAmbientTemperature: ambientTemperature)
print("the bulb's temperature is \(bulbTemperature)")

// ASSOCIATED VALUES
// allows you to attach data to instances of an enumeration and different cases can have different types of associated values
enum ShapeDimensions {
    // point has no associated value - it is dimensionless
    case point
    
    // square's associated value is the length of one side
    case square (side: Double)
    
    // rectangle's associated value defines its width and height
    case rectangle (width: Double, height: Double)
    
    case rightTriangle (side1: Double, side2: Double, side3: Double)
    
    func area() -> Double {
        switch self {
        case .point:
            return 0
        case let .square(side: side):
            return side * side
        case let .rectangle (width: w, height: h):
            return w * h
        default:
            return 0
        }
    }
    func perimeter() -> Double {
        switch self {
        case .point:
            return 0
        case let .square(side: side):
            return side * 4
        case let .rectangle (width: w, height: h):
            return (2 * w) + (2 * h)
        case let .rightTriangle (side1: side1, side2: side2, side3: side3):
            return side1 + side2 + side3
        }
    }
}

// creating shapes
var squareShape = ShapeDimensions.square(side: 10.0)
var rectShape = ShapeDimensions.rectangle(width: 5.0, height: 10.0)
var pointShape = ShapeDimensions.point
var rightTriangle = ShapeDimensions.rightTriangle(side1: 2, side2: 3, side3: 4)

// go back and add a function to compute area
print ("square's area = \(squareShape.area())")
print ("rectangle's area = \(rectShape.area())")
print("point's area = \(pointShape.area())")
print("rightTriangle's area = \(rightTriangle.area() )")
print ("square's perimeter = \(squareShape.perimeter())")
print ("rectangle's perimeter = \(rectShape.perimeter())")
print("point's perimeter = \(pointShape.perimeter())")
print("rightTriangle's perimeter = \(rightTriangle.perimeter())")


// RECURSIVE ENUMERATIONS
// imagine creating a family tree...if you know one or two of a person's parents, you can track ancestors up from there...

//enum FamilyTree {
//    case noKnownParents
//    case oneKnownParent(name: String, ancestors: FamilyTree)
//    case twoKnownParents(fatherName: String, fatherAncestors: FamilyTree,
//        motherName: String, motherAncestors: FamilyTree)
//}
// written as above, you get the message: Playground execution failed: error: BigNerdRanchSwiftChapter14Enumerations.playground:187:6: error: recursive enum 'FamilyTree' is not marked 'indirect'.  FamilyTree is recursive because its cases have an associated value that is also of the type FamilyTree.
// this matters because the compiler is trying to figure out how much memory an enum instance requires  and the way it is written would require an infinite amount of memory.  see more detailed explanation on p.159)

// written with indirect (called a pointer), the compiler now knows to store a pointed to the associated data, putting the data somewhere else in the memory rather than making the instance big enough to hold the data
//indirect enum FamilyTree {
//    case noKnownParents
//    case oneKnownParent(name: String, ancestors: FamilyTree)
//    case twoKnownParents(fatherName: String, fatherAncestors: FamilyTree,
//        motherName: String, motherAncestors: FamilyTree)
//}

// alternately, mark the recursive cases as indirect
enum FamilyTree {
    case noKnownParents
    indirect case oneKnownParent(name: String, ancestors: FamilyTree)
    indirect case twoKnownParents(fatherName: String, fatherAncestors: FamilyTree,
        motherName: String, motherAncestors: FamilyTree)
}

//fred's family tree
let fredAncestors = FamilyTree.twoKnownParents(fatherName: "Fred Sr.", fatherAncestors: .oneKnownParent(name: "Beth", ancestors: .noKnownParents), motherName: "Marsha", motherAncestors: .noKnownParents)

// BRONZE CHALLENGE
// add perimeter function to ShapeDimensions enum 
// see above for code

// SILVER CHALLENGE
// add a case to ShapeDimensions enum for a right triangle.  this causes an error in the area method.  fix the error.
// adding the case rightTriangle makes the error appear that the switch is not exhaustive.  however, you can't compute the area without knowing which side (1, 2 or 3 is on the right angle.  so i fixed this using a default and returning 0.  



