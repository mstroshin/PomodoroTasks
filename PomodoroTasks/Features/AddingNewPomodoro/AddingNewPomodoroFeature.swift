import Foundation
import ComposableArchitecture

enum PomodoroType: String, Identifiable, CaseIterable {
    var id: String {
        rawValue
    }

    case inAction
    case `break`
}

struct AddingNewPomodoroFeature: Reducer {
    struct State: Equatable {
        var type: PomodoroType = .inAction
        var timeInMinutes: Int?

        var defaultTimeInMinutes: Int {
            switch type {
            case .inAction: return 45
            case .break: return 5
            }
        }

        var isTimeValid: Bool {
            timeInMinutes != nil
        }
    }
    enum Action {
        case onAppear
        case selectedType(PomodoroType)
        case typeTime(String)
        case done
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            state.timeInMinutes = state.defaultTimeInMinutes
            return .none

        case let .selectedType(type):
            state.type = type
            return .none

        case .done:
            return .none

        case let .typeTime(timeString):
            if timeString.isEmpty {
                state.timeInMinutes = nil
                return .none
            }

            let filtered = timeString
                .components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined()

            if let minutes = Int(filtered) {
                state.timeInMinutes = minutes
            }
            return .none
        }
    }
}
