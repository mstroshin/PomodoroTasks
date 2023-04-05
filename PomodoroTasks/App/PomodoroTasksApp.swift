import SwiftUI
import AppKit
import Foundation
import ComposableArchitecture
import SwiftDate

@main
struct PomodoroTasksApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            view
        }
        .windowResizability(.contentSize)
        .onChange(of: scenePhase) { _ in
//            PersistenceController.shared.save()
        }
    }

    var view: some View {
        let tasks = IdentifiedArrayOf(uniqueElements: [
            TaskFeature.State(title: "1", pomodoros: IdentifiedArrayOf(uniqueElements: [
                PomodoroTimerState(type: .inAction, initialTimeInMinutes: 1),
                PomodoroTimerState(type: .break, initialTimeInMinutes: 1)
            ])),
            TaskFeature.State(title: "2", pomodoros: IdentifiedArrayOf(uniqueElements: [
                PomodoroTimerState(type: .inAction, initialTimeInMinutes: 1),
                PomodoroTimerState(type: .break, initialTimeInMinutes: 1)
            ])),
        ])
        let days = IdentifiedArrayOf(uniqueElements: Date.weekDates.map { date in
            if date.compare(toDate: Date(), granularity: .day) == .orderedSame {
                return DayFeature.State(date: date, tasks: tasks)
            }
            return DayFeature.State(date: date, tasks: [])
        })
        let currentDayIndex = Date().weekday - Calendar.autoupdatingCurrent.firstWeekday

        return MainView(
            store: StoreOf<MainFeature>(
                initialState: .init(
                    days: days,
                    selectedWeekDayIndex: currentDayIndex
                ),
                reducer: MainFeature()._printChanges()
            )
        )
    }
}
