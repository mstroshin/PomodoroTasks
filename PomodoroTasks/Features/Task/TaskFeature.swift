import SwiftUI
import Combine
import ComposableArchitecture

struct TaskFeature: Reducer {
    enum Destination: Equatable {
        case addingNewPomodoro(Int)
    }
    struct State: Equatable, Identifiable {
        let id = UUID()
        let title: String
        var destination: Destination?
//        var pomodoros: IdentifiedArrayOf<PomodoroState> = []
//        var currentPomodoro: PomodoroState?
        var isPlaying: Bool = false
    }
    enum Action {
        case addPomodoroPressed
        case startPomodoroPressed
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .addPomodoroPressed:
            return .none

        case .startPomodoroPressed:
            return .none
        }
    }
}
