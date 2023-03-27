import Foundation
import ComposableArchitecture
import SwiftDate

struct DayFeature: Reducer {
    struct State: Equatable, Identifiable {
        let id: UUID = UUID()
        let date: Date

        var title: String {
            date.weekdayName(.short)
        }

        var tasks: IdentifiedArrayOf<TaskFeature.State> = []

        @PresentationState var addingNewTask: AddingNewTaskFeature.State?
    }
    enum Action {
        case addTaskPressed
        case addingNewTask(PresentationAction<AddingNewTaskFeature.Action>)

        case task(id: TaskFeature.State.ID, action: TaskFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addTaskPressed:
                state.addingNewTask = .init()
                return .none

            case .addingNewTask(.presented(.done)):
                guard let addingNewTask = state.addingNewTask else { return .none }
                let newTask = TaskFeature.State(title: addingNewTask.title)
                state.tasks.append(newTask)
                state.addingNewTask = nil
                return .none

            case .addingNewTask:
                return .none

            case .task:
                return .none
            }
        }
        .forEach(\.tasks, action: /Action.task(id:action:)) {
            TaskFeature()
        }
        .ifLet(\.$addingNewTask, action: /Action.addingNewTask) {
            AddingNewTaskFeature()
        }
    }

}
