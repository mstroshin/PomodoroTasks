import Foundation

final class MainViewModel: ObservableObject {
    let daysOfWeek = Calendar.autoupdatingCurrent.shortWeekdaySymbols
    @Published var dayPickerSelection = 0

    init() {

    }

}
