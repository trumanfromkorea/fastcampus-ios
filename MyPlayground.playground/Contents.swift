import Foundation
import UIKit


var commonFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko")
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter
}

var KST: Date {
    let dateString = commonFormatter.string(from: Date())
    let accurateDay = commonFormatter.date(from: dateString)!

    return accurateDay
}

var today = KST
var dateList = [String]()

var weekBeforeToday = Calendar.current.date(byAdding: .day, value: -6, to: KST)!

for i in 0 ..< 7 {
    let incrementDate = Calendar.current.date(byAdding: .day, value: i, to: weekBeforeToday)
    dateList.append(commonFormatter.string(from: incrementDate!))
}

print(dateList)
