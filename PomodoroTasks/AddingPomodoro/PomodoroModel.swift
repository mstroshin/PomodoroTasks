import Foundation

enum TimerType: String, CaseIterable, Identifiable {
    case inAction = "In Action"
    case `break` = "Break"

    var id: String {
        rawValue
    }
}

struct PomodoroModel: Identifiable {
    let id: UUID = UUID()
    let type: TimerType
    let time: Date
}
