import Foundation
import ComposableArchitecture
import SwiftDate

struct MainFeature: Reducer {
    struct State: Equatable {
        static let weekdayNames = Date.weekdayNames
        var days: IdentifiedArrayOf<DayFeature.State>
        var selectedWeekDayIndex: Int

        var selectedDay: DayFeature.State {
            get {
                days[selectedWeekDayIndex]
            }
            set {
                days[selectedWeekDayIndex] = newValue
            }
        }
    }
    enum Action {
        case onAppear
        case weekDayPressed(Int)

        case timerTick(
            dayId: DayFeature.State.ID,
            taskId: TaskFeature.State.ID,
            pomidoroId: PomodoroTimerState.ID
        )

        case day(DayFeature.Action)
    }

    @Dependency(\.continuousClock) private var clock
    private enum TimerID {}

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none

            case let .weekDayPressed(index):
                state.selectedWeekDayIndex = index
                return .none

            case let .day(.task(taskId, .startPomodoroPressed)):
                let day = state.selectedDay
                guard let task = day.tasks[id: taskId] else { return .none }
                if task.isPlaying {
                    state.days[state.selectedWeekDayIndex].tasks[id: taskId]?.isPlaying = false
                    return .cancel(id: TimerID.self)
                }
                guard let currPomodoroId = task.currentPomodoroId else { return .none }

                state.days[state.selectedWeekDayIndex].tasks[id: taskId]?.isPlaying = true
                for id in day.tasks.ids where id != taskId {
                    state.days[state.selectedWeekDayIndex].tasks[id: id]?.isPlaying = false
                }

                return .run { [dayId = day.id] send in
                    for await _ in clock.timer(interval: .milliseconds(1000)) {
                        await send(.timerTick(dayId: dayId, taskId: taskId, pomidoroId: currPomodoroId))
                    }
                }.cancellable(id: TimerID.self, cancelInFlight: true)

            case let .day(.task(taskId, .removePomodoro(pomodoroId))):
                if state.selectedDay.tasks[id: taskId]?.currentPomodoroId == pomodoroId {
                    return .cancel(id: TimerID.self)
                }
                return .none

            case .day:
                return .none

            case let .timerTick(dayId, taskId, currPomodoroId):
                state.days[id: dayId]?
                    .tasks[id: taskId]?
                    .pomodoros[id: currPomodoroId]?
                    .timePassedInSeconds += 1

                if state.days[id: dayId]?.tasks[id: taskId]?.pomodoros[id: currPomodoroId]?.isCompleted == true {
                    state.days[id: dayId]?.tasks[id: taskId]?.isPlaying = false
                    return .cancel(id: TimerID.self)
                }
                return .none
            }
        }

        Scope(state: \.selectedDay, action: /Action.day) {
            DayFeature()
        }
    }
    
}
