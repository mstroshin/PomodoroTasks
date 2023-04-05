import Foundation

final class MainViewModel: ObservableObject {
    static let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    private let days: [DayViewModel]
    @Published var selectedWeekDayIndex: Int
    
    func weekDayPressed(index: Int) {
        selectedWeekDayIndex = 1
    }
}
