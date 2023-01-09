import Foundation

final class TaskViewModel: ObservableObject, Identifiable {
    enum Destination {
        case addingNewPomodoro(AddingPomodoroViewModel)
    }

    let id: UUID
    let title: String

    @Published var destination: Destination?
    @Published var timers: [PomodoroModel] = []

    init(
        id: UUID = UUID(),
        title: String
    ) {
        self.id = id
        self.title = title
    }

    func addingPomodoroButtonPressed() {
        let vm = AddingPomodoroViewModel()
        vm.onCreatedPomodoro = { [weak self] newTimer in
            self?.timers.append(newTimer)
            self?.destination = nil
        }
        destination = .addingNewPomodoro(vm)
    }

}
