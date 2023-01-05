import Foundation

final class MainViewModel: ObservableObject {
    enum Destination {
        case addingNewTask(AddingNewTaskViewModel)
    }

    let daysOfWeek = Calendar.autoupdatingCurrent.shortWeekdaySymbols
    @Published var dayPickerSelection = 0
    @Published var destination: Destination?
    @Published var tasks: [TaskViewModel] = []

    init() {

    }

    func addNewTaskButtonPressed() {
        let newTaskViewModel = AddingNewTaskViewModel()
        newTaskViewModel.doneHandler = { [weak self] newTaskTitle in
            self?.tasks.append(TaskViewModel(title: newTaskTitle))
            self?.destination = nil
        }

        destination = .addingNewTask(newTaskViewModel)
    }

}
