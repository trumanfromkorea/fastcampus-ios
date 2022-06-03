import Combine
import Foundation

// MARK: -PassthroughSubject

// output type String
// failure type Never - 실패할리 없다
let relay = PassthroughSubject<String, Never>()
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")

// MARK: - CurrentValueSubject
// output type 에 대한 초기값이 필요함

let variable = CurrentValueSubject<String, Never>("")
variable.send("Initial text")

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
// --> subscription2 received value:
// --> subscription2 received value: More text
//
// subscription 이 생겼을때 기존에 가지고 있던 value 한번 보내고
// 그 다음에 받은 value 보냄
variable.value

let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(relay)
publisher.subscribe(variable)
