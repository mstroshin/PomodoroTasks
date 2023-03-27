import Foundation
import ComposableArchitecture

struct MainFeature: Reducer {
    struct State: Equatable {
        var days: IdentifiedArrayOf<DayFeature.State>
        var selectedDay: DayFeature.State
    }
    enum Action {
        case onAppear
        case dayPressed(DayFeature.State.ID)
        case day(DayFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none

            case let .dayPressed(dayId):
                state.selectedDay = state.days[id: dayId]!
                return .none

            case .day:
                return .none
            }
        }
    }
    
}
