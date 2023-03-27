import SwiftUI
import AppKit
import Foundation
import ComposableArchitecture

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
        let days = IdentifiedArrayOf(uniqueElements: Date.weekDates.map { DayFeature.State(date: $0) })
        let currentDayIndex = Date().weekday - Calendar.autoupdatingCurrent.firstWeekday
        let selectedDay = days[currentDayIndex]

        return MainView(
            store: StoreOf<MainFeature>(
                initialState: .init(
                    days: days,
                    selectedDay: selectedDay
                ),
                reducer: MainFeature()._printChanges()
            )
        )
    }
}
