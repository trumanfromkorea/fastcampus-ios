//: [Previous](@previous)

import Combine
import Foundation

let arrayPublisher = [1, 2, 3].publisher

let queue = DispatchQueue(label: "custom")

/*
 custom thread 에서 작업을 수행한 후
 main thread 에서 데이터를 받는 과정
 */
let subscription = arrayPublisher
    .subscribe(on: queue)
    .map { value -> Int in
        print("transform: \(value), thread: \(Thread.current)")
        return value
    }
    .receive(on: DispatchQueue.main)
    .sink { value in
        print("Received Value: \(value), thread: \(Thread.current)")
    }

//: [Next](@next)
