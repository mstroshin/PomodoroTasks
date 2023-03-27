import Foundation
import ComposableArchitecture

struct AddingNewTaskFeature: Reducer {
    struct State: Equatable {
        var title: String = ""
    }
    enum Action {
        case type(String)
        case done
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .type(title):
            state.title = title
            return .none

        case .done:
            return .none
        }
    }
}
