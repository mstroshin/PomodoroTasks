import Foundation
import SwiftUI
import SwiftDate

extension Color {

    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
}

extension Array {

    func shiftRight(_ amount: Int = 1) -> [Element] {
        guard count > 0 else { return self }
        var amount = amount

        assert(-count...count ~= amount, "Shift amount out of bounds")
        if amount < 0 { amount += count }  // this needs to be >= 0

        return Array(self[amount ..< count] + self[0 ..< amount])
    }

}

extension Date {

    static var weekDates: [Date] {
        let now = DateInRegion()
        let startOfThisWeek = now.dateAtStartOf(.weekOfYear)
        let endOfThisWeek = now.dateAtEndOf(.weekOfYear)
        let increment = DateComponents(day: 1)

        let weekDates = DateInRegion.enumerateDates(from: startOfThisWeek, to: endOfThisWeek, increment: increment)

        return weekDates.map { $0.date }
    }

    static var weekdayNames: [String] {
        weekDates.map { $0.weekdayName(.short) }
    }

}
