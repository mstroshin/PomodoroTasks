import SwiftUI
import Combine
import ComposableArchitecture

struct TaskFeature: Reducer {
    struct State: Equatable, Identifiable {
        let id = UUID()
        let title: String
        var pomodoros: IdentifiedArrayOf<PomodoroTimerState> = []

        var currentPomodoroId: PomodoroTimerState.ID? {
            pomodoros.first(where: { !$0.isCompleted })?.id
        }

        var isPlaying = false

        @PresentationState var addingPomodoro: AddingNewPomodoroFeature.State?
    }
    enum Action {
        case addPomodoroPressed
        case startPomodoroPressed

        case addingPomodoro(PresentationAction<AddingNewPomodoroFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addPomodoroPressed:
                state.addingPomodoro = .init()
                return .none

            case .startPomodoroPressed:
                return .none

            case .addingPomodoro(.presented(.done)):
                guard let newPomodoro = state.addingPomodoro else { return .none }
                let pomodoro = PomodoroTimerState(
                    type: newPomodoro.type,
                    initialTimeInMinutes: newPomodoro.timeInMinutes ?? newPomodoro.defaultTimeInMinutes
                )
                state.pomodoros.append(pomodoro)
                state.addingPomodoro = nil
                return .none

            case .addingPomodoro:
                return .none
            }
        }
        .ifLet(\.$addingPomodoro, action: /Action.addingPomodoro) {
            AddingNewPomodoroFeature()
        }
    }

}
