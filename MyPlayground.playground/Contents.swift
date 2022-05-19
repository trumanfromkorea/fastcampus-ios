import UIKit

protocol HasArea {
    var area: Double { get }
}

// HasArea 준수
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

// HasArea 준수
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

// HasArea 미준수
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

// 공유된 기본 클래스가 없지만 AnyObject 로 배열 생성
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
// Area is 12.5663708
// Area is 243610.0
// Something that doesn't have an area
