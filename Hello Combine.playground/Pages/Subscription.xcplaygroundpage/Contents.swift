//: [Previous](@previous)

import Combine
import Foundation

let subject = PassthroughSubject<String, Never>()

// The print() operator prints you all lifecycle events
let subscription = subject
    .print("[Debug]")
    .sink { value in
        print("Subscriber received value: \(value)")
    }

subject.send("Hello")
subject.send("Hello again!")
subject.send("Hello for the last time!")

//subject.send(completion: .finished) // --> publisher 에서 끊는 경우
subscription.cancel() // --> subscriber 에서 끊는 경우

//subject.send("Hello ?? :(")

//: [Next](@next)
