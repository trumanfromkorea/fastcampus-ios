//: [Previous](@previous)

import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

// removeDuplicates
let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher

words
    .removeDuplicates()
    .sink { value in
        print(value)
    }
    .store(in: &subscriptions)

// compactMap
let strings = ["a", "1.24", "3", "def", "45"].publisher

strings
    .compactMap { Float($0) }
    .sink { value in
        print(value)
    }
    .store(in: &subscriptions)

// ignoreOutput

let numbers = (1 ... 10000).publisher

numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)

// prefix

let tens = (1 ... 10).publisher

tens
    .prefix(2)
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)

//: [Next](@next)
