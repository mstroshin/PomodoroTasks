import Foundation

final class AddingPomodoroViewModel: ObservableObject {
    @Published var type: TimerType = .inAction
    @Published var time: Date = .now

    var onCreatedPomodoro: ((PomodoroModel) -> Void)?

    func doneButtonPressed() {
        let model = PomodoroModel(type: type, time: time)
        onCreatedPomodoro?(model)
    }
}
