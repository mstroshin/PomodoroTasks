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

        var tasks: [TaskFeature.State] = []

        @PresentationState var addingNewTask: AddingNewTaskFeature.State?
    }
    enum Action {
        case addTaskPressed
        case addingNewTask(PresentationAction<AddingNewTaskFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addTaskPressed:
                state.addingNewTask = .init()
                return .none

//            case let .addingNewTask(.presented(action)):
//                switch action {
//                case .done:
//                    guard let addingNewTask = state.addingNewTask else { return .none }
//                    let newTask = TaskFeature.State(title: addingNewTask.title)
//                    state.tasks.append(newTask)
//                    return .none
//
//                case .type:
//                    return .none
//                }
            case .addingNewTask:
                return .none
            }
        }
        .ifLet(\.$addingNewTask, action: /Action.addingNewTask) {
            AddingNewTaskFeature()
        }
    }

}
