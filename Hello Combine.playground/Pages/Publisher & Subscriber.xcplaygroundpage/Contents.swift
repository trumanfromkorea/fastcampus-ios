//: [Previous](@previous)

import Combine
import Foundation

// Publisher & Subscriber

let just = Just(1000) // 데이터 한번 전송하고 끝
let subscription = just.sink { value in
    print("Received Value: \(value)")
}

let arrayPublisher = [1, 3, 5, 7, 9].publisher
let subscription2 = arrayPublisher.sink { value in
    print("Received Value: \(value)")
}

class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
let subscription3 = arrayPublisher.assign(to: \.property, on: object) // 어떤 오브젝트의 어떤 프로퍼티인지
//object.property = 3

print("Final Value: \(object.property)")

//: [Next](@next)
